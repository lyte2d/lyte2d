do-c:
	lua lib/defs_to_c.lua

do-txt:
	lua lib/defs_to_tree.lua > output/_lyte_api.txt

do-ts:
	lua lib/defs_to_typescript.lua > output/_lyte_api.d.ts

do-lua:
	lua lib/defs_to_inspectoutput.lua > output/_lyte_api.lua

all: do-ts do-lua do-c do-txt

.PHONY: all do-ts do-lua do-c do-txt
