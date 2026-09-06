project "yaml-cpp"

location "%{wks.location}/vendor/%{prj.name}"

files {
	"%{prj.location}/src/**.cpp",
	"%{prj.location}/src/**.h"
}

includedirs {
	"%{prj.location}/include"
}