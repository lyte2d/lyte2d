## Changelog

### Lyte1D alpha v0.6 (...)

### Lyte1D alpha v0.5 (2023.05.27)
- Added missing APIs/
- API changes
- Bugfixes
- lyte command-line arguments
  - lyte (non WASM) now accepts a first argument without a name. It's assigned to "dir="
- Internal/Fundamentals
  - Builds:
    - Build simplified. Docker support added for local build
    - Docker based build support added for "official" binaries
    - Github actions based builds. All binaries will be coming from Github machines from now on.
  - API codegen:
    - Lua API code is generated so it's easier and less erorr-prone to add APIs

### Lyte1D alpha v0.4 (2023.02.25)
- Error messages now contain the filename
- More consistent API and string contants
- Removed some experimental APIs
- WIP: Removed built-in fennel support
  - TODO in -1.5: remove but make it easy to use any other lua language
- Added a fennel sample
- Windows GUI exe, for distrubution.
  - This one does not create a CMD window
  - Mainly aimed at players, not devs

### Lyte1D alpha v0.3 (2023.02.13)
- Custom shader support
- Executable name changed 'lyte1d' to 'lyte'
- Bugfixes
- Meta: Semantic API docs/types in Lua tables
  - Website is generated from that
  - API doc (.d.ts file) is generated from that
  - (Future) REPL completions will use that
- Meta: Better webpage, examples, guide

### Lyte1D alpha v0.2 (2023.01.24)
- Linux support (works on Ubuntu 17+ and SteamDeck)
- All APIs moved to 'lyte' namespace
- Experimental: Fennel language support
- REPL support. Change stuff while your game is running.
  - `lyte repl=lua`  or `lyte repl=fennel` to get started
- Bugfixes
- Meta:
  - Website: API reference is now in new TS based syntax
  - Website: Web page is auto generated from template
  - Repo: Changelog file (this file) created :)

### Lyte1D alpha v0.1 (2022.12.21)
- Initial release
