.PHONY: do-inspect do-fnl do-ts do-tl do-lua do-c output-dir  all

default: all

#all: output-dir do-c do-tldo-ts do-lua do-fnl

all: output-dir do-c do-tl do-ts do-lua

do-inspect:
	lua lib/defs_to_inspectoutput.lua > output/_lyte_api_inspect.lua

do-fnl:
	# (fennel lib/defs_to_fenneloutput.fnl) | tail -n +3 | cat > output/_lyte_api.fnl
	(fennel lib/defs_to_fenneloutput.fnl) | cat > output/_lyte_api.fnl

do-ts:
	lua lib/defs_to_typescript.lua > output/lyte.d.ts

do-tl:
	lua lib/defs_to_teal.lua > output/lyte.d.tl

do-lua:
	lua lib/defs_to_docstrings.lua > output/lyte.lua

do-c:
	lua lib/defs_to_c.lua

output-dir:
	mkdir -p output



