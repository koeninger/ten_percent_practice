#ifndef _LEXER_INTERNAL_
#define _LEXER_INTERNAL_

#include <core.h>

typedef struct LexerInternal LexerInternalType;

struct LexerInternal {
    const char *buf; // Character buffer

    size_t offset; // current read offset into the buffer
    size_t length;


    TokenType *tokenHead; // a linked list of tokens
    TokenType *tokenTail;

    LexerInternalType *child;
};

#endif
