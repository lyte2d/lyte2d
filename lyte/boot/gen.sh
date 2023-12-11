# update boot zip
# depends on "xxd" linux command line tool (apt install)

rm -rf 'tmp'
mkdir -p 'tmp'
cd boot && zip -9 -u -r ../tmp/boot.zip . && cd ..
cd tmp  && xxd -i boot.zip ../include/_boot_zip_generated.c && cd ..
rm -rf tmp

