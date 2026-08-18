workspace "aurora"
architecture "x86_64"
configurations { "debug", "release" }

multiprocessorcompile "On"
language "C++"
cppdialect "C++23"
cdialect "C17"
staticruntime "On"
stringpooling "On"
editandcontinue "Off" -- Must be off for tracy to work

-- Default project type to staticlib, most projects are actually dependencies and follow this
kind "StaticLib"
targetdir "%{wks.location}/bin/%{cfg.buildcfg}"
objdir "%{wks.location}/bin_int/%{cfg.buildcfg}"
symbols "On"

filter "configurations:debug"
runtime "Debug"
optimize "Debug"
defines "_DEBUG"

filter "configurations:release"
runtime "Release"
optimize "Speed"
defines "NDEBUG"

filter "system:windows"
systemversion "latest"
defines { "NOMIXMAX", "WIN32_LEAN_AND_MEAN", "_CRT_SECURE_NO_WARNINGS" }
buildoptions { "/EHsc", "/Zc:throwingNew", "/Zc:preprocessor", "/Zc:__cplusplus", "/experimental:c11atomics" }

defines "TRACY_ENABLE"

startproject "launcher"
include "aurora/build.lua"
include "launcher/build.lua"

group "dependencies"
for _, matchedfile in ipairs(os.matchfiles("premake/*.lua")) do
	include(matchedfile)
end
