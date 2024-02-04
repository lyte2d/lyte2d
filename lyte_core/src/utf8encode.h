// mg

#ifndef UTF8ENCODE_H_INCLUDED
#define UTF8ENCODE_H_INCLUDED

#include <stdint.h>
#include <stddef.h>

int utf8encode_into(uint32_t* codepoints, size_t num_codepoints, char **buf, size_t buf_size);
char *utf8encode_alloc(uint32_t *codepoints, size_t num_codepoints);

#endif // UTF8ENCODE_H_INCLUDED