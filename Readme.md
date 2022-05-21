# cpp-modules-test

Test of C++ module compilation with clang.

Unfortunately the version of clang/llvm included with xcode 13 doesn't include support for modules, so uses [silkeh/clang](https://hub.docker.com/r/silkeh/clang) docker image.

See [ecosta.dev](https://blog.ecosta.dev/en/tech/cpp-modules-with-clang)


### Module precompilation approach

Unfortunately a module map is required, for reasons I don't understand (it seems like it should be very easy to give the compiler all source files/compilation units to munch on, and for the compiler when encountering one importing an uncompiled module, defer these units to the end of the compilation phase, but that must not be feasible for some reason).

- Here we first compile the module file(s) into `./*.pcm`.
- Then compile main using `-c -fprebuilt-module-path=.`
- Then link with `clang++ *.pcm *.o -o test`

From [clang.llvm.org/docs/Modules.html](https://clang.llvm.org/docs/Modules.html):

> -fprebuilt-module-path=\<directory\>
>
> Specify the path to the prebuilt modules. If specified, we will look for modules in this directory for a given top-level module name. We don’t need a module map for loading prebuilt modules in this directory and the compiler will not try to rebuild these modules. This can be specified multiple times.
