#include "l_imgui.hpp"

#include <cstddef>
#include <string>

#include <imgui.h>
#include <misc/cpp/imgui_stdlib.h>

namespace {
	int gWindowStackCount{};

	int l_imgui_Begin(lua_State* L){
		++gWindowStackCount;
		lua_pushboolean(L, ImGui::Begin(luaL_checkstring(L, 1)));
		return 1;
	}

	int l_imgui_End(lua_State* L) {
		--gWindowStackCount;
		ImGui::End();
		return 0;
	}

	int l_imgui_TextUnformatted(lua_State* L) {
		std::size_t size;
		char const* str = luaL_checklstring(L, 1, &size);
		ImGui::TextUnformatted(str, str + size);
		return 0;
	}

	int l_imgui_Separator(lua_State* L) {
		ImGui::Separator();
		return 0;
	}

	int l_imgui_SeparatorText(lua_State* L) {
		ImGui::SeparatorText(luaL_checkstring(L, 1));
		return 0;
	}

	int l_imgui_InputText(lua_State* L) {
		char const* label = luaL_checkstring(L, 1);
		std::string text = luaL_checkstring(L, 2);
		bool edited = ImGui::InputText(label, &text);
		lua_pushlstring(L, text.data(), text.size());
		lua_pushboolean(L, edited);
		return 2;
	}

	int l_imgui_Button(lua_State* L) {
		lua_pushboolean(L, ImGui::Button(luaL_checkstring(L, 1)));
		return 1;
	}

	int l_imgui_InputTextMultiline(lua_State* L) {
		char const* label = luaL_checkstring(L, 1);
		std::string text = luaL_checkstring(L, 2);
		bool edited = ImGui::InputTextMultiline(label, &text);
		lua_pushlstring(L, text.data(), text.size());
		lua_pushboolean(L, edited);
		return 2;
	}
}

#define AUR_STRINGIFY(x) AUR_STRINGIFY_IMPL(x)
#define AUR_STRINGIFY_IMPL(x) #x

#define AUR_EXPAND(name) do {\
lua_pushliteral(L, AUR_STRINGIFY(name));\
lua_pushcfunction(L, l_imgui_ ## name);\
lua_rawset(L, -3);\
} while(0)

namespace aurora {
	void l_recover_stack() {
		for (int i = 0; i < gWindowStackCount; ++i) {
			ImGui::End();
		}

		gWindowStackCount = 0;
	}

	void l_register_imgui(lua_State* L) {
		lua_newtable(L);

		AUR_EXPAND(Begin);
		AUR_EXPAND(End);
		AUR_EXPAND(TextUnformatted);
		AUR_EXPAND(Separator);
		AUR_EXPAND(SeparatorText);
		AUR_EXPAND(InputText);
		AUR_EXPAND(Button);
		AUR_EXPAND(InputTextMultiline);

		lua_setglobal(L, "ImGui");
	}
}

#undef AUR_EXPAND