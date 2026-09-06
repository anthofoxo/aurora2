project "aurora"
kind "SharedLib"
debugdir "%{wks.location}/working"

files {
	"**.c",
    "**.cc",
	"**.cpp",
	"**.h",
    "**.hh",
	"**.hpp",
	"**.inl",
}

includedirs {
	"%{prj.location}",
	"%{prj.location}/vendor",
	"%{wks.location}/vendor/glfw/include",
	"%{wks.location}/vendor/imgui",
	"%{wks.location}/vendor/tracy/public",
	"%{wks.location}/vendor/lua/src",
	"%{wks.location}/vendor/spdlog/include",
	"%{wks.location}/vendor/zip/src",
	"%{wks.location}/vendor/yaml-cpp/include",
}

links {
	"glfw",
	"imgui",
	"lua",
	"zip",
	"yaml-cpp",
	--"tracy",
}

filter "system:windows"
links "opengl32"
defines "FMT_UNICODE=0"
