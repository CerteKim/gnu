# GNU Utils For Android
This module installs the latest of various GNU binaries I've cross compiled for android. This current includes (with toolchain used):
* Bash (v5.07) (Linaro for arm64, NDK for others)
* Bc (v1.07.1) (NDK) - also includes dc
* Coreutils with advanced cp/mv (v8.31) (Linaro for arm/64, GCC for others) - includes extra patches that adds progress bar function
* Cpio (v2.12) (NDK)
* Diffutils (v3.7) (NDK) - this includes cmp, diff, diff3, and sdiff
* Ed (v1.15) (NDK) - also includes red
* Findutils (v4.6.0) (Linaro for arm/64, GCC for others) - this includes find, bigram, code, frcode, locate, updatedb, and xargs
* Gawk (Awk) (v5.0.1) (NDK) - also includes grcat and pwcat
* Grep (v3.3) (NDK) - also includes egrep and fgrep
* Gzip (v1.10) (NDK) - also includes gunzip, gzexe, uncompress, zcat, zcmp, zdiff, zegrep, zfgrep, zforce, zgrep, zless, zmore, and znew
* Ncurses (v6.1) (NDK) - this includes clear, infocmp, ncurses6-config, tabs, tic, toe, tput, and tset
* Patch (v2.7.6) (NDK)
* Sed (v4.7) (NDK)
* Tar (v1.32) (Linaro for arm/64, GCC for others)
These are all static binaries. Arm/arm64 compiled with linaro, x86/x64 compiled with GNU gcc

[More details in support thread](https://forum.xda-developers.com/android/software-hacking/mods-zackptg5-s-misc-projects-t3881164).

## Compatibility
* Android Jellybean+
* All root solutions

## Change Log
### v3.4 - 10.24.2019
* Disable sort and timeout binaries by default due to seccomp issues on many roms - you can remove the .bak extension from them if they're usable on your rom

### v3.3 - 9.4.2019
* Remove auto bash opening - no longer modifies terminalmods
* Fix .aliases call
* Compile tar without NDK due to fortify security error

### v3.2 - 8.11.2019
* Unity v4.4 update

### v3.1 - 8.7.2019
* Fine tune and fix .bash/mkshrc/aliases and such
* Make sure mkshrc doesn't conflict with terminalmods mkshrc (will disable this one in favor of it if detected)

### v3.0 - 8.6.2019
* Attempt to fix paths in binaries and such
* Always install to /system/bin
* Have bash as default shell using mkshrc - true solution, doesn't break anything so far as I know
* Update awk to v5.0.1
* Recompile all binaries - use NDK when possible
* Separate sort and timeout binaries from single coreutils binary again since some roms have issues with them
* Add 'cu' function to call coreutils progs (Usage Ex: cu cp --help)

### v2.1 - 6.4.2019
* Added back missing bash files

### v2.0 - 5.29.2019
* Added bc
* Added cpio
* Added diffutils
* Added ed
* Added findutils
* Added grep
* Added gzip
* Added ncurses
* Added patch
* Added tar

### v1.1 - 5.19.2019
* Added Awk (Gawk)

### v1.0 - 5.17.2019
* Initial release

## Credits
* [GNU](https://www.gnu.org/software)

## Source Code
* Module [GitHub](https://github.com/Zackptg5/GNU-Utils-Android)
