project "zip"

location "%{wks.location}/vendor/%{prj.name}"

files {
	"%{prj.location}/src/*.c",
	"%{prj.location}/src/*.h"
}