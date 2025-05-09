# Lyte2D

## IMPORTANT NOTE

I'm looking for a new owner/maintainer for Lyte2D. It's a small but powerful game framework for Lua, written in C. It's inspired by LOVE2D but it's even simpler. 1MB or smaller binaries on each platform. Single namespace (everything is under "lyte."), single function to implement ("lyte.tick(...)") instead of update/draw etc. It runs on Windows, Linux, and browsers (WASM) out of the box. MacOS works fine too, but we don't yet have a CI/official build for it yet.

Here're some highlights:
- Simple shapes; lines, circles, rects etc. Transforms...
- Image drawing, including partial rectangles from the image.
- Blend modes (default: alpha blending) and filter modes (default: nearest neighbor for pixel crisp games)
- Audio: looping music and sound effects, pan and pitch control.
- Keyboard/mouse/gamepad input.
- Async fetching application zip for larger game archives
- LOVE2D style app fusing: single executable that's made with merging lyte binary and your game zip. (Works on Windows and Linux, not tested on Mac)
- Single HTML file (that contains an embedded WASM file) for web distribution
- TTF fonts; rendering and font atlas. Crisp performant text rendering (I'm proud with this one)
- Built with Sokol using OpenGL3.3 and GLES3 backends, meaning shaders are shared between ALL targets without code changes. Shader uniform/image params are defined in Lua code. Shaders can be embedded inside Lua files
- It used to have a REPL, Fennel/Teal languages builtin and a half-working physics implementation, but removed these as they were not seeing much use
- Used in jam games, several experiments such as text editors etc.
- Used in one professional Steam game!
- Tiny tiny community, this was not marketed much at all. Couple reddit posts in r/lua and some tweets
- Website: https://lyte2d.com, with guide, samples in wasm and API surface
- Github: https://github.com/lyte2d/lyte2d

The reason I'm looking for a new owner is that I unable to spend the energy this little engine deserves. With the removal of the jankier parts I mentioned above, the remaining API I think is at beta level right now.  It would be the new owners path to either keep it with small bug fixes as is, or take it further with more features, different direction etc.

In my opinion, even without a lot of fixes or new features at all, with the right marketing, this little thing can shine.

The correct owner would have some native code experience, he/she would know his way around C/cmake/git/CIs etc even if an expertise is NOT required.

Are you interested? Please DM me here or on twitter or on gmail, tell me what's your general idea of the direction you'd like to take, and your github. If you'd like to join only as a contributor (but not owner) let me know as well.

At "morew4rd" (github, twitter, gmail, reddit -- same handle)

Thank you!


## What

Lyte2D is a comfy little Lua framework for game development that is OSS and free. Lyte2D is a work in progress!

## Links

- [Lyte2D website](https://lyte2d.com)
- [Releases](https://github.com/lyte2d/lyte2d/releases)
- [User Guide](guide.html)
- [Developer Doc](dev.md) (For building Lyte2D from scratch, and learning about the general architecture)
- [Example Code](https://github.com/lyte2d/lyte2d/tree/main/samples)
- [Github Discussions](https://github.com/lyte2d/lyte2d/discussions)
- [Discord](https://discord.gg/BKPfQrCaNU)
