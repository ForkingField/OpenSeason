# OpenSeason - PlayStation 1, aka. PSX Emulator

OpenSeason is an simulator/emulator of the Sony PlayStation(TM) console, focusing on playability, speed, and long-term maintainability. The goal is to be as accurate as possible while maintaining performance suitable for low-end devices. "Hack" options are discouraged, the default configuration should support all playable games with only some of the enhancements having compatibility issues.

A PS1 or PS2 "BIOS" ROM image is required to to start the emulator and to play games. You can use an image from any hardware version or region, although mismatching game regions and BIOS regions may have compatibility issues. A ROM image is not provided with the emulator for legal reasons, you should dump this from your own console using Caetla or other means.

## Features

OpenSeason features a fully-featured frontend built using Qt, as well as a fullscreen/TV UI based on Dear ImGui.

<p align="center">
  <img src="https://github.com/ForkingField/OpenSeason/raw/md-images/main-qt.png" alt="Main Window Screenshot" />
  <img src="https://github.com/ForkingField/OpenSeason/raw/md-images/bigduck.png" alt="Fullscreen UI Screenshot" />
</p>

Other features include:

 - CPU Recompiler/JIT (x86-64, armv7/AArch32, AArch64, RISC-V/RV64).
 - Hardware (D3D11, D3D12, OpenGL, Vulkan, Metal) and software rendering.
 - Upscaling, texture filtering, and true colour (24-bit) in hardware renderers.
 - Accurate blending via Rasterizer Order Views/Fragment Shader Interlock.
 - PGXP for geometry precision, texture correction, and depth buffer emulation.
 - Motion adaptive deinterlacing.
 - Adaptive downsampling filter.
 - Screen rotation for vertical or "TATE" shmup games.
 - Post processing shader chains (GLSL and Reshade FX).
 - "Fast boot" for skipping BIOS splash/intro.
 - Save state support, with runahead and rewind.
 - Supports reading directly from CD, bin/cue images, raw bin/img files, MAME CHD, single-track ECM, MDS/MDF, and unencrypted PBP formats.
 - Preloading of disc images to RAM to avoid disk sleeping hitches.
 - Automatic loading/applying of PPF patches.
 - Direct booting of homebrew executables.
 - Direct loading of Portable Sound Format (psf) files.
 - Time stretched audio when running outside of 100% speed, and surround sound expansion.
 - Digital and analog controllers for input (rumble is forwarded to host).
 - GunCon and Justifier lightgun support (simulated with mouse).
 - NeGcon support.
 - Qt and "Big Picture" UI.
 - Automatic updates with preview and latest channels.
 - Automatic content scanning - game titles/hashes are provided by redump.org.
 - Optional automatic switching of memory cards for each game.
 - Supports loading cheats from existing lists.
 - Memory card editor and save importer.
 - Emulated CPU overclocking.
 - Integrated and remote debugging.
 - Multitap controllers (up to 8 devices).
 - RetroAchievements.
 - Discord Rich Presence.
 - Video capture with FFmpeg backends.

## System Requirements
 - A CPU faster than a potato. But it needs to be x86_64 (SSE4.1), AArch32/armv7, AArch64/ARMv8, or RISC-V/RV64.
 - For the hardware renderers, a GPU capable of OpenGL 3.1/OpenGL ES 3.1/Direct3D 11 Feature Level 10.0 (or Vulkan 1.0) and above. So, basically anything made in the last 10 years or so.
 - SDL, XInput or DInput compatible game controller (e.g. XB360/XBOne/XBSeries).

## Downloading and running

For x86 machines (most systems), you will need a CPU that supports the SSE4.1 instruction set. This includes all CPUs manufactured after 2007. If you want to use OpenSeason with a CPU that is older, [0.1.6995](https://github.com/ForkingField/OpenSeason/tree/0.1.6995) is the last version that does not require SSE4.1.

### LibCrypt protection and SBI files

A number of PAL region games use LibCrypt protection, requiring additional CD subchannel information to run properly. libcrypt not functioning usually manifests as hanging or crashing, but can sometimes affect gameplay too, depending on how the game implemented it.

For these games, make sure that the CD image and its corresponding SBI (.sbi) file have the same name and are placed in the same directory. OpenSeason will automatically load the SBI file when it is found next to the CD image.

For example, if your disc image was named `Spyro3.cue`, you would place the SBI file in the same directory, and name it `Spyro3.sbi`.

CHD images with built-in subchannel information are also supported.

## User Directories
The "User Directory" is where you should place your BIOS images, where settings are saved to, and memory cards/save states are saved by default.
An optional [SDL game controller database file](#sdl-game-controller-database) can be also placed here.

This is located in the following places:

- `$XDG_DATA_HOME/openseason`, or `~/.local/share/openseason`.

So, if you were using Linux, you would place your BIOS images in `~/.local/share/openseason/bios`. This directory will be created upon running OpenSeason
for the first time.

If you wish to use a "portable" build, where the user directory is the same as where the executable is located, create an empty file named `portable.txt`
in the same directory as the OpenSeason executable.

## Bindings for Qt frontend
Your keyboard or game controller can be used to simulate a variety of PlayStation controllers. Controller input is supported through DInput, XInput, and SDL backends and can be changed through `Settings -> General Settings`.

To bind your input device, go to `Settings -> Controllers`. Each of the buttons/axes for the simulated controller will be listed, alongside the corresponding key/button on your device that it is currently bound to. To rebind, click the box next to the button/axis name, and press the key or button on your input device that you wish to bind to. When binding rumble, simply press any button on the controller you wish to send rumble to.

## SDL Game Controller Database
OpenSeason releases ship with a database of game controller mappings for the SDL controller backend, courtesy of https://github.com/mdqinc/SDL_GameControllerDB. The included `gamecontrollerdb.txt` file can be found in the `resources` subdirectory of the OpenSeason program directory.

If you are experiencing issues binding your controller with the SDL controller backend, you may need to add a custom mapping to the database file. Make a copy of `gamecontrollerdb.txt` and place it in your [user directory](#user-directories) (or directly in the program directory, if running in portable mode) and then follow the instructions in the [SDL_GameControllerDB repository](https://github.com/mdqinc/SDL_GameControllerDB) for creating a new mapping. Add this mapping to the new copy of `gamecontrollerdb.txt` and your controller should then be recognized properly.

## Default bindings
Controller 1:
 - **Left Stick:** W/A/S/D
 - **Right Stick:** T/F/G/H
 - **D-Pad:** Up/Left/Down/Right
 - **Triangle/Square/Circle/Cross:** I/J/L/K
 - **L1/R1:** Q/E
 - **L2/R2:** 1/3
 - **L3/R3:** 2/4
 - **Start:** Enter
 - **Select:** Backspace

Hotkeys:
 - **Escape:** Open Pause Menu
 - **F11:** Toggle Fullscreen
 - **Tab:** Temporarily Disable Speed Limiter
 - **Space:** Pause/Resume Emulation

## Disclaimers

"PlayStation" and "PSX" are registered trademarks of Sony Interactive Entertainment Europe Limited. This project is not affiliated in any way with Sony Interactive Entertainment.
