# **NOT PRODUCTION OR TESTING READY**

### What is Aurora v0.3
Aurora v0.3.x is a full rewrite of Aurora. Aurora v0.1 and prior has been written in C++ and had a lot of its own issues.

### Problems with Older Versions
In an attempt to move away from C++ Aurora v0.2 was born. Idea being development would be easier and more accesible outside of C++ but the ambitions were also increased. Not only do we generate/modify game files. We also hook into the Thumper executable itself. This requires a C layer and thus we now had multiple layers of languages to deal with. This also introduces some SEVERE performance issues.

### When Will it Be Done?
Whenever it's ready. Current version operate just fine. I cannot develop this under huge pressure. But be assured it is being worked on despite the contents of this branch.

### Why Rewrite Now?
Aurora v0.2 was left in a fairly stable state. It performed the job it needed to do fairly well. But left a lot to be desired. Especially any non-windows users. v0.2 required useage of containers and weird installation methods on unix systems. Moving back into C++ solves all these mentioned issues.

### How
So moving back to C++ may seem like a backward step considering we just left it. But given the requirements of Aurora. This is the only real choice here. However the complexity of C++ is still very much not wanted. To combat this we will use Lua. This language is the only good choice I could find for this. It fits the following requirements very nicely.

1. Enbeddable runtime: The entire language runtime is directly compiled into C/C++. Meaning scripting code never has to leave the process or invoke external code.
1. It's fast: Lua is a relativly fast scripting language. You'll rarely see any performance concerns for our use case.
1. No compilers required: We want Aurora to remain accessible and easy to work on. This means anyone can download a build and poke around freely.
1. No compile times: C++ has natoriously long compile times. This sidesteps that issue.
1. Debugability: While lua isn't the greatest in this department. It's C api gives us enough power to diagnose issues fairly easily.

---

# Aurora
Aurora is the modern Thumper modding toolchain. Custom levels, binary introspection, custom scoring tables, multiple language support and more.

Aurora is the sucessor to TML and should be the preffered mod loading tool.

## Documentation
Detailed documentation and guides are available [here](https://anthofoxo.xyz/aurora).

## Building
A few steps are required for building. Firstly this project makes use of submodules. Make sure to clone the repo with submodules.

`git clone --recurse-submodules https://github.com/anthofoxo/aurora`

While aurora functions fine under Wine. It's still designed to be compiled and ran on Windows and MSVC. Visual Studio 2022 is highly recommended for Aurora.