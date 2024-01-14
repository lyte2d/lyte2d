## code defs, gen, etc.

### defs
- all of the lyte API surface is defined in these defs_lyte*.lua files
- the definition syntax is a "custom" dsl, see lib folder for the code. should be simple enough

### codegen
- gen_api.sh creates files in the output folder, which should be copied to their proper locations after inspection.
- output/typings go to top level typings folder
- output/code/ .h file goes to include folder (this one should not change ever really shoud not need to update it often)
- output/code/ _gen.c file goes to src folder without being edited (this one changes if API shape changes)
- output/code/ _impl__EDIT__.c file goes to src folder, but needs to be renamed and edited. practically it needs to be manually merged with the existing _impl.c file
- output/code/ _gen.lua file goes to ../boot/boot folder (this is the pure lua API part, as opposed to native-lua API part)
- if boot files are changed gen_boot.sh also needs to be called. this is to "embed" lua parts of the code inside the exe.
