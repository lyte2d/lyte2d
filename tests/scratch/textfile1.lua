local txt = lyte.load_textfile "files/hello.txt"
print("TXT IS (1): " .. txt)

lyte.save_textfile("tmp/h1.txt", "test #1\n")

txt = lyte.load_textfile "tmp/h1.txt"
print("TXT IS (2): " .. txt)

lyte.save_textfile_append("tmp/h1.txt", "test #2\n")


txt = lyte.load_textfile "tmp/h1.txt"
print("TXT IS (2): " .. txt)

