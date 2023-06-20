LYTE=l.exe

EXAMPLES=../../examples
PONGOUT=../../games/pongout

default:
	echo "run samples, games etc"

clean:
	rm -rf ./tmp/**

##### SAMPLES
pongout:
	${LYTE} dir=${PONGOUT}
s01:
	${LYTE} dir=${EXAMPLES} app=s01_hello
s02:
	${LYTE} dir=${EXAMPLES} app=s02_movement
s03:
	${LYTE} dir=${EXAMPLES} app=s03_music
s04:
	${LYTE} dir=${EXAMPLES} app=s04_soundfx
s05:
	${LYTE} dir=${EXAMPLES} app=s05_canvas
s06:
	${LYTE} dir=${EXAMPLES} app=s06_basic_shader
s07:
	${LYTE} dir=${EXAMPLES} app=s07_basic_shader2
s08:
	${LYTE} dir=${EXAMPLES} app=s08_shader_spinning_plus
s09:
	${LYTE} dir=${EXAMPLES} app=s09_shader_canvas

##### TESTS

# shaders, sounds etc. mess :)
test1:
	${LYTE} app=test1

# image basic stress
test2:
	${LYTE} app=test2

# fil io
file1:
	${LYTE} app=textfile1


