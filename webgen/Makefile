# static html generator based on:
# https://qiita.com/lazythunk/items/10c18522b42e56e79659

# make -- builds the website
# make all -- (same) builds the website
# make clean -- cleans the website

# just change these two
SRCDIR=../websrc/
# OUTDIR=../out/website_new
OUTDIR=../website

# optionally these also. dir names under SRCDIR
SRC_NAME=pages
PUB_NAME=public/

rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

default: all

# the following is generic
CP= cp -r
RM= rm -rf
MKDIR= mkdir -p
LS= ls -al
# LUA= lua -l lib/fix_paths
# LUA= lua -e "package.path = '${SRCDIR}/?.lua;' .. package.path"
LUA= lua -e "package.path='${SRCDIR}/?.lua;'..package.path;H=require'html';print'<!-- Generated. Do not edit manually! -->'"

REL=${OUTDIR}/
SRC=${SRCDIR}/${SRC_NAME}/
PUB=${SRCDIR}/${PUB_NAME}/
ASSETS= $(REL)${PUB_NAME}/
HTML= $(patsubst $(SRC)%.lua, $(REL)%.html, $(call rwildcard,${SRC},*.lua))

all: $(REL) $(HTML) $(ASSETS)
	${LS} ${REL}

$(REL)%.html: $(SRC)%.lua
	mkdir -p $(@D)
	$(LUA) $< > $@

$(REL):
	$(MKDIR) $(REL)

$(ASSETS):
	$(CP) ${PUB} $(ASSETS)

clean:
	$(RM) ${REL}

.PHONY: all clean