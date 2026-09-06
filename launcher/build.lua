project "launcher"
debugdir "%{wks.location}/working"
files "*.cpp"
links "aurora"

kind "ConsoleApp"

filter "configurations:Release"
kind "WindowedApp"