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
}

links {
	"glfw",
	"imgui",
	"lua",
	--"tracy",
}

filter "system:windows"
links "opengl32"
defines "FMT_UNICODE=0"
