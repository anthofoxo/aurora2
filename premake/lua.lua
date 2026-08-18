project "lua"

location "%{wks.location}/vendor/lua"

files {
	"%{prj.location}/src/*.c",
	"%{prj.location}/src/*.h"
}

removefiles { 
	"%{prj.location}/src/lua.c",
	"%{prj.location}/src/luac.c",
}