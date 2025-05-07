## code defs, gen, etc.

### defs
- all of the lyte API surface is defined in these defs_lyte*.lua files
- the definition syntax is a "custom" dsl, see lib folder for the code. should be simple enough

- NOTE: this folder `api_defs_dsl` can be deleted. Any API changes from there on would be handled manually. This is
  if there's desire to remove the LUA based API definitions DSL.

### codegen
- gen_api.sh creates files in the `./output` folder, which should be copied to their proper locations after inspection.

- output/typings go to top level typings folder
- output/code/ NAMESPACE.h and NAMESPACE_gen.c file goes to src folder without being edited (this one changes if API shape changes)
- output/code/ NAMESPACE_impl__EDIT__.c file goes to src folder, but needs to be renamed and edited. practically it needs to be manually merged with the existing _impl.c file
- output/code/ NAMESPACE_gen.lua file goes to ../boot/boot folder (this is the pure lua API part, as opposed to native-lua API part)
  - if boot files are changed gen_boot.sh also needs to be called. this is to "embed" lua parts of the code inside the exe.
  - it's in ../boot folder
