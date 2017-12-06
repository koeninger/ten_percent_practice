#ifndef _LEXER_INTERNAL_
#define _LEXER_INTERNAL_

typedef struct LexerInternal LexerInternalType;

struct LexerInternal {
    const char *buf; // Character buffer

    off_t offset; // current read offset into the buffer


};

#endif
