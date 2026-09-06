#ifndef _WIN32
#	error The aurora launcher only supports windows
#endif

#include <cstdlib>
#include <iostream>

#include <Windows.h>

static void crit_error(char const* aError) {
	std::cerr << aError << '\n';
	MessageBoxA(nullptr, aError, "Aurora Launcher Error", MB_ICONERROR);
}

int main(int argc, char* argv[]) {
	if (auto module = LoadLibraryA("aurora.dll")) {
		if (auto startproc = (void(*)(void))GetProcAddress(module, "aur_startup")) {
			std::cerr << "Procedure OK\n";
			startproc();
		}
		else {
			crit_error("Failed to find startup procedure: `aur_startup`");
		}
		// FreeLibrary(module);
	}
	else {
		crit_error("Failed to load `aurora.dll`");
	}

	return EXIT_SUCCESS;
}

int WINAPI wWinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPWSTR lpCmdLine, _In_ int nShowCmd) {
	return main(__argc, __argv);
}