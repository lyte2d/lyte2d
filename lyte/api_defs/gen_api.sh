mkdir output
mkdir output/dbg
mkdir output/code
mkdir output/typings

echo "Debug output: tag raw tree. this is before being it's processed"
lua -e "print((require 'lib.tag.tag_pp')(require 'defs_lyte'.raw_tree) .. '\n')" > output/dbg/_lyte_tagtree.txt
lua -e "print((require 'lib.tag.tag_pp')(require 'defs_lyte_core'.raw_tree) .. '\n')" > output/dbg/_lyte_core_tagtree.txt

echo "Debug output:  kikito's inspect output (lua table format) (post-processed tree)"
lua -e "print('return ' .. (require 'lib.tag.inspect')(require'defs_lyte'.tree, {indent='    '}) .. '\n')" > output/dbg/_lyte_tree.inspect.lua
lua -e "print('return ' .. (require 'lib.tag.inspect')(require'defs_lyte_core'.tree, {indent='    '}) .. '\n')" > output/dbg/_lyte_core_tree.inspect.lua


echo "Typings: in Lua for VSCode"
lua -e "print(require('lib.defs_to_docstrings')(require'defs_lyte'.tree))" > output/typings/lyte.lua
lua -e "print(require('lib.defs_to_docstrings')(require'defs_lyte_core'.tree))" >> output/typings/lyte.lua

echo "Typings: in Typescript (documentation)"
lua -e "print(require('lib.defs_to_typescript')(require'defs_lyte'.tree))" > output/typings/lyte.d.ts
# lua -e "print(require('lib.defs_to_typescript')(require'defs_lyte_core'.tree))" >> output/typings/lyte.d.ts

echo "Typings: in Teal (documentation)"
lua -e "print(require('lib.defs_to_teal')(require'defs_lyte'.tree))" > output/typings/lyte.d.tl
# lua -e "print(require('lib.defs_to_teal')(require'defs_lyte_core'.tree))" >> output/typings/lyte.d.tl



echo "API: Lua (boot) (source: defs_lyte)"
lua -e "print(require('lib.gen_api_luaboot')(require'defs_lyte'.tree))" > output/code/api_lyte_gen.lua

echo "API: Native C (source: defs_lyte_core)"
lua -e "print(require('lib.gen_api_native')(require'defs_lyte_core'.tree, 'output/code'))"

