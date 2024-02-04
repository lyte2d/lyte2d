// mg

#include "utf8encode.h"

#include <stdlib.h>

unsigned codepoint_to_utf8(uint8_t* utf8, uint32_t codepoint) {
    if (codepoint <= 0x7F) {
        utf8[0] = codepoint;
        return 1;
    }
    if (codepoint <= 0x7FF) {
        utf8[0] = 0xC0 | (codepoint >> 6);
        utf8[1] = 0x80 | (codepoint & 0x3F);
        return 2;
    }
    if (codepoint <= 0xFFFF) {
        // detect surrogates
        if (codepoint >= 0xD800 && codepoint <= 0xDFFF) return 0;
        utf8[0] = 0xE0 | (codepoint >> 12);
        utf8[1] = 0x80 | ((codepoint >> 6) & 0x3F);
        utf8[2] = 0x80 | (codepoint & 0x3F);
        return 3;
    }
    if (codepoint <= 0x10FFFF) {
        utf8[0] = 0xF0 | (codepoint >> 18);
        utf8[1] = 0x80 | ((codepoint >> 12) & 0x3F);
        utf8[2] = 0x80 | ((codepoint >> 6) & 0x3F);
        utf8[3] = 0x80 | (codepoint & 0x3F);
        return 4;
    }
    return 0;
}


int utf8encode_into(uint32_t* codepoints, size_t num_codepoints, char **buf, size_t buf_size) {
    if (num_codepoints == 0) {
        return 1;
    }
    if (buf_size < num_codepoints * 4 + 1) {
        return 1;
    }
    char* p = *buf;
    for (size_t i = 0; i < num_codepoints; ++i) {
        uint8_t buffer[4];
        unsigned len = codepoint_to_utf8(buffer, codepoints[i]);
        if (len == 0) {
            return 1;
        }
        for (unsigned j = 0; j < len; ++j) {
            *p++ = buffer[j];
        }
    }
    *p = '\0';
    return 0;
}

char* utf8encode_alloc(uint32_t* codepoints, size_t num_codepoints) {
    if (num_codepoints == 0) {
        return NULL;
    }
    size_t buf_size = num_codepoints * 4 + 1;
    char* utf8 = malloc(buf_size);
    if (utf8encode_into(codepoints, num_codepoints, &utf8, buf_size) != 0) {
        free(utf8);
        return NULL;
    }
    return utf8;
}
