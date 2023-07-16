## VSCode code completion and debugging sample

Have the following vs plugins installed
- lua language server by sumneko (for code completion, f2-renames, type hints and errors etc.)
- local lua debugger by tom blind

Put lyte.exe in the path. And hit F5. If you don't have any errors, the app should just start. If you place a breakpoint, you can trigger it.

`lyte.lua` contains "docstring" style type annotations that lua language server can parse and use.
`tasks.json` contains the recipe to start lyte.exe in debug mode