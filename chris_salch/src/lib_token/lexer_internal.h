#ifndef _LEXER_INTERNAL_
#define _LEXER_INTERNAL_

#include <core.h>

#include <token.h>

typedef struct LexerInternal LexerInternalType;
typedef int (*TokenMatcherPtr)(LexerInternalType *ptr, TokenType *token);

struct LexerInternal {
    const wchar_t *buf; // Character buffer

    size_t offset; // current read offset into the buffer
    size_t length;

    size_t line;
    size_t column;

    TokenMatcherPtr matchers[256];

    TokenType *tokenHead; // a linked list of tokens
    TokenType *tokenTail;

    LexerInternalType *child;
};

/**
 * Add token matchers to the passed in lexer
 *
 */
void attachMatchers(LexerInternalType *lexer);


#endif
