#include <iostream>

#include <Windows.h> // Fix APIENTRY redefinition

#include <GLFW/glfw3.h>
#include <lua.hpp>

#include <imgui.h>
#include <imgui_internal.h>
#include <backends/imgui_impl_glfw.h>
#include <backends/imgui_impl_opengl3.h>
#include <misc/cpp/imgui_stdlib.h>

#include <zip.h>

#include <spdlog/spdlog.h>

#include <fstream>
#include <filesystem>
#include <vector>
#include <span>
#include <regex>

#include "l_imgui.hpp"

#include "aur_lua_serialize.hpp"

static void glfw_error_callback(int error, const char* description) {
	spdlog::critical("GLFW Error {}: {}", error, description);
}

int c_error_handler(lua_State* L) {
	const char* msg = lua_tostring(L, 1);
	if (msg) {
		// Appends the full stack trace to the original error message
		luaL_traceback(L, L, msg, 1);
	}
	else if (!lua_isnoneornil(L, 1)) {
		// Handle non-string error objects safely
		luaL_traceback(L, L, lua_tostring(L, 1), 1);
	}
	else {
		luaL_traceback(L, L, "(no error message)", 1);
	}
	return 1; // Return the new string containing the trace
}

std::string diagnostic;

int load_binary(lua_State* L) {
	std::size_t pathsize;
	auto const* pathdata = reinterpret_cast<char8_t const*>(luaL_checklstring(L, 1, &pathsize));
	auto const path = std::filesystem::path(std::u8string_view(pathdata, pathsize));

	std::ifstream stream{ path, std::ios::binary | std::ios::in };

	if (!stream) return luaL_error(L, "failed to open file");

	stream.seekg(0, std::ios::end);
	auto filesize = stream.tellg();

	if (filesize < 0) return luaL_error(L, "failed to determine file size");

	stream.seekg(0, std::ios::beg);

	auto const size = static_cast<std::size_t>(filesize);

	luaL_Buffer buffer;
	char* data = luaL_buffinitsize(L, &buffer, size);

	if (size != 0 && !stream.read(data, static_cast<std::streamsize>(size))) return luaL_error(L, "failed to read file");

	luaL_pushresultsize(&buffer, size);
	return 1;
}


int write_binary(lua_State* L) {
	std::size_t pathsize;
	auto const* pathdata = reinterpret_cast<char8_t const*>(luaL_checklstring(L, 1, &pathsize));
	auto const path = std::filesystem::path(std::u8string_view(pathdata, pathsize));


	std::size_t datasize;
	auto const* datadata = luaL_checklstring(L, 2, &datasize);
	auto const data = std::string_view(datadata, datasize);

	std::filesystem::create_directories(path.parent_path());

	std::ofstream stream{ path, std::ios::binary | std::ios::out };

	if (!stream) return luaL_error(L, "failed to open file");

	stream.write(data.data(), data.size());

	return 0;
}


void set_timeout_hook(lua_State* L) {
	lua_sethook(L, [](lua_State* L, lua_Debug* ar) -> void {
		luaL_error(L, "%s", "Forced termination: Execution Timeout");
		}, LUA_MASKCOUNT, 100'000'000);
}

void run(lua_State* L) {
	lua_settop(L, 0);
	diagnostic.clear();

	lua_pushcfunction(L, c_error_handler);
	int errfunc_index = lua_gettop(L);

	if (luaL_loadfile(L, "aurora/launch.lua") != LUA_OK) {
		diagnostic += lua_tostring(L, -1);
		lua_pop(L, 1);
	}
	else {
		set_timeout_hook(L);

		if (lua_pcall(L, 0, LUA_MULTRET, errfunc_index) != LUA_OK) {
			diagnostic += lua_tostring(L, -1);
			lua_pop(L, 1);
		}
	}

	lua_remove(L, errfunc_index);
}

std::uint32_t fnv1a(std::span<std::byte const> aBytes) {
	std::uint32_t hash = 0x811c9dc5;

	for (auto byte : aBytes) {
		hash = (hash ^ static_cast<std::uint32_t>(byte)) * 0x1000193;
	}

	hash *= 0x2001;
	hash = hash ^ (hash >> 0x7);
	hash *= 0x9;
	hash = hash ^ (hash >> 0x11);
	hash *= 0x21;

	return hash;
}

int fnv1a_lua(lua_State* L) {
	std::size_t size;
	std::byte const* data = reinterpret_cast<std::byte const*>(luaL_checklstring(L, 1, &size));
	lua_pushinteger(L, fnv1a(std::span(data, size)));
	return 1;
}

#include <yaml-cpp/yaml.h>

int list_files(lua_State* L) {
	std::size_t pathsize;
	auto const* pathdata = reinterpret_cast<char8_t const*>(luaL_checklstring(L, 1, &pathsize));
	auto const path = std::filesystem::path(std::u8string_view(pathdata, pathsize));

	if (!std::filesystem::exists(path)) return luaL_error(L, "Directory not found");

	lua_newtable(L);

	int index = 1;

	for (auto const& entry : std::filesystem::directory_iterator(path)) {
		if (!entry.is_regular_file()) continue;
		auto str = entry.path().filename().generic_u8string();
		lua_pushlstring(L, reinterpret_cast<char const*>(str.data()), str.size());
		lua_rawseti(L, -2, index++);
	}

	return 1;
}

void yaml_to_lua(lua_State* L, YAML::Node const& node) {
	if (!node || node.IsNull()) {
		lua_pushnil(L);
		return;
	}

	if (node.IsMap()) {
		lua_newtable(L);

		for (auto const& pair : node) {
			// Key
			yaml_to_lua(L, pair.first);

			// Value
			yaml_to_lua(L, pair.second);

			lua_settable(L, -3);
		}

		return;
	}

	if (node.IsSequence()) {
		lua_newtable(L);

		int index = 1;

		for (auto const& child : node) {
			yaml_to_lua(L, child);
			lua_rawseti(L, -2, index++);
		}

		return;
	}

	if (node.IsScalar()) {
		auto const value = node.Scalar();

		if (value == "true") {
			lua_pushboolean(L, true);
		}
		else if (value == "false") {
			lua_pushboolean(L, false);
		}
		else {
			// Could alternatively always use lua_pushstring()
			lua_pushlstring(L, value.data(), value.size());
		}

		return;
	}

	lua_pushnil(L);
}

#include "imgui_hex.h"

int l_unzip(lua_State* L) {
	char const* path = luaL_checkstring(L, 1);
	auto* zip = zip_open(path, 0, 'r');

	if (!zip) {
		return luaL_error(L, "Cannot open zip file: %s", path);
	}

	lua_newtable(L);

	int luaIdx = 1;

	for (int i = 0; i < zip_entries_total(zip); ++i) {
		zip_entry_openbyindex(zip, i);
		if (zip_entry_isdir(zip)) {
			zip_entry_close(zip);
			continue;
		}

		lua_newtable(L);

		const char* name = zip_entry_name(zip);
		lua_pushliteral(L, "name");
		lua_pushstring(L, name);
		lua_rawset(L, -3);

		auto size = zip_entry_size(zip);

		std::string string;
		string.resize(size);

		zip_entry_noallocread(zip, string.data(), string.size());

		// Keep an untouched copy for the binary/plain-text fallback.
		std::string originalString = string;

		if (originalString[0] == '{') {
			try {
				lua_pushliteral(L, "content");
				YAML::Node node = YAML::Load(string);
				yaml_to_lua(L, node);
				lua_rawset(L, -3);
			}
			catch (YAML::ParserException const& e2) {
				lua_pushliteral(L, "warn");
				lua_pushstring(L, e2.what());
				lua_rawset(L, -4);

				// JSON requires a space between key/value pairs.
				// Attempt to fix this for old TCL levels.
				string = std::regex_replace(
					string,
					std::regex(":(\\S)"),
					": $1"
				);

				try {
					YAML::Node node = YAML::Load(string);
					yaml_to_lua(L, node);
					lua_rawset(L, -3);
				}
				catch (YAML::ParserException const& e) {
					// Parsing failed; use the original unmodified data.
					lua_pushlstring(L, originalString.data(), originalString.size());
					lua_rawset(L, -3);

					lua_pushliteral(L, "error");
					lua_pushstring(L, e.what());
					lua_rawset(L, -3);
				}
			}
		}
		else {
			lua_pushliteral(L, "content");
			lua_pushlstring(L, originalString.data(), originalString.size());
			lua_rawset(L, -3);
		}

		

		zip_entry_close(zip);

		lua_rawseti(L, -2, luaIdx++);
	}

	zip_close(zip);

	return 1;
}

void load_api(lua_State* L) {
	lua_newtable(L);

	lua_pushliteral(L, "load_binary");
	lua_pushcfunction(L, load_binary);
	lua_rawset(L, -3);

	lua_pushliteral(L, "write_binary");
	lua_pushcfunction(L, write_binary);
	lua_rawset(L, -3);

	lua_pushliteral(L, "fnv1a");
	lua_pushcfunction(L, fnv1a_lua);
	lua_rawset(L, -3);

	lua_pushliteral(L, "unzip");
	lua_pushcfunction(L, l_unzip);
	lua_rawset(L, -3);

	lua_pushliteral(L, "list_files");
	lua_pushcfunction(L, list_files);
	lua_rawset(L, -3);

	lua_pushliteral(L, "serialize");
	lua_pushcfunction(L, [](lua_State* L) -> int{
		auto str = aurora::lapi_serialize(L);
		lua_pushlstring(L, str.data(), str.size());
		return 1;
		});
	lua_rawset(L, -3);

	lua_setglobal(L, "Aurora");

	aurora::l_register_imgui(L);
}

int panic_func(lua_State* L) {
	char const* msg = (lua_type(L, -1) == LUA_TSTRING) ? lua_tostring(L, -1) : "error object is not a string";
	spdlog::error("PANIC: unprotected error in call to Lua API ({})", msg);
	return 0;
}

int print_func(lua_State* L) {
	int n = lua_gettop(L);

	std::stringstream ss;

	for (int i = 1; i <= n; i++) {
		char const* str = lua_tostring(L, i);

		if (str) ss << str;
		else ss << "[non-string]";

		if (i < n) ss << "\t";
	}

	auto const str = ss.str();

	spdlog::info(str);
	diagnostic += str;
	diagnostic += '\n';

	return 0;
}

extern "C" __declspec(dllexport) void __cdecl aur_startup(void) {
	lua_State* L = lua_newstate(luaL_alloc, nullptr, luaL_makeseed(nullptr));

	if (L) {
		lua_atpanic(L, panic_func);
		// Do not load the following librariesL LUA_LOADLIBK, LUA_OSLIBK, LUA_DBLIBK, LUA_IOLIBK
		//luaL_openselectedlibs(L, LUA_GLIBK | LUA_COLIBK | LUA_STRLIBK | LUA_UTF8LIBK | LUA_TABLIBK | LUA_MATHLIBK, 0);
		luaL_openlibs(L);
		lua_register(L, "print", print_func); // override
		load_api(L);
		run(L);
	}

	glfwSetErrorCallback(glfw_error_callback);

	glfwInit();

	auto const* vidmode = glfwGetVideoMode(glfwGetPrimaryMonitor());
	int width = static_cast<int>(vidmode->width * 0.8f);
	int height = static_cast<int>(vidmode->height * 0.8f);
	glfwWindowHint(GLFW_POSITION_X, vidmode->width / 2 - width / 2);
	glfwWindowHint(GLFW_POSITION_Y, vidmode->height / 2 - height / 2);

	float main_scale = ImGui_ImplGlfw_GetContentScaleForMonitor(glfwGetPrimaryMonitor());
	GLFWwindow* window = glfwCreateWindow(width, height, "Aurora v0.3.0-a.1", nullptr, nullptr);

	glfwMakeContextCurrent(window);
	glfwSwapInterval(1);

	IMGUI_CHECKVERSION();
	ImGui::CreateContext();
	ImGuiIO& io = ImGui::GetIO();
	io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;
	io.ConfigFlags |= ImGuiConfigFlags_DockingEnable;

	ImGui::StyleColorsDark();

	ImGuiStyle& style = ImGui::GetStyle();
	style.ScaleAllSizes(main_scale);
	style.FontScaleDpi = main_scale;
	io.ConfigDpiScaleFonts = true;
	io.ConfigDpiScaleViewports = true;

	io.Fonts->AddFontFromFileTTF("NotoSansMono-Regular.ttf", 20.0f);

	if (io.ConfigFlags & ImGuiConfigFlags_ViewportsEnable) {
		style.WindowRounding = 0.0f;
		style.Colors[ImGuiCol_WindowBg].w = 1.0f;
	}

	ImGui_ImplGlfw_InitForOpenGL(window, true);
	ImGui_ImplOpenGL3_Init("#version 330 core");

	
	ImGuiHexEditorState hex_state;

	hex_state.Bytes = (void*)&ImGui::GetIO();
	hex_state.MaxBytes = sizeof(ImGuiIO);

	while (!glfwWindowShouldClose(window)) {
		glfwPollEvents();

		if (glfwGetWindowAttrib(window, GLFW_ICONIFIED) != 0) {
			ImGui_ImplGlfw_Sleep(10);
			continue;
		}

		ImGui_ImplOpenGL3_NewFrame();
		ImGui_ImplGlfw_NewFrame();
		ImGui::NewFrame();

		ImGui::DockSpaceOverViewport();
		if (ImGui::BeginMainMenuBar()) {
			if (ImGui::BeginMenu("File")) {

				if (ImGui::MenuItem("Quit")) {
					glfwSetWindowShouldClose(window, GLFW_TRUE);
				}

				ImGui::EndMenu();
			}

			ImGui::EndMainMenuBar();
		}

		ImGui::ShowDemoWindow();

		if (ImGui::Begin("Hex Viewer")) {
			ImGui::BeginHexEditor("##HexEditor", &hex_state);
			ImGui::EndHexEditor();
		}
		ImGui::End();


		lua_pushcfunction(L, c_error_handler);
		int errfunc_index = lua_gettop(L);

		set_timeout_hook(L);

		if (lua_getglobal(L, "Update") == LUA_TFUNCTION) {
			if (lua_pcall(L, 0, 0, errfunc_index) != LUA_OK) {
				diagnostic = "";
				diagnostic += lua_tostring(L, -1);
				lua_pop(L, 1);
			}
			
			aurora::l_recover_stack();
		}
		else lua_pop(L, 1);
		lua_remove(L, errfunc_index);

		if (ImGui::Begin("Diagnostics")) {
			if (ImGui::Button("Run")) {
				run(L);
			}

			ImGui::TextUnformatted(diagnostic.c_str(), diagnostic.c_str() + diagnostic.size());
		}
		ImGui::End();

		ImGui::Render();
		int display_w, display_h;
		glfwGetFramebufferSize(window, &display_w, &display_h);
		glViewport(0, 0, display_w, display_h);
		glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		ImGui_ImplOpenGL3_RenderDrawData(ImGui::GetDrawData());

		if (io.ConfigFlags & ImGuiConfigFlags_ViewportsEnable) {
			GLFWwindow* backup_current_context = glfwGetCurrentContext();
			ImGui::UpdatePlatformWindows();
			ImGui::RenderPlatformWindowsDefault();
			glfwMakeContextCurrent(backup_current_context);
		}

		glfwSwapBuffers(window);
	}

	ImGui_ImplOpenGL3_Shutdown();
	ImGui_ImplGlfw_Shutdown();
	ImGui::DestroyContext();

	glfwMakeContextCurrent(nullptr);
	glfwDestroyWindow(window);
	glfwTerminate();

	lua_close(L);
}