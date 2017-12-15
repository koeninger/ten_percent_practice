#ifndef _LEXER_INTERNAL_
#define _LEXER_INTERNAL_

#include <core.h>

#include <wctype.h>
#include <wchar.h>

#include <token.h>

typedef struct LexerInternal LexerInternalType;

struct LexerInternal {
    const wchar_t *buf; // Character buffer

    size_t offset; // current read offset into the buffer
    size_t length;

    size_t line;
    size_t column;

    TokenType *tokenHead; // a linked list of tokens
    TokenType *tokenTail;

    LexerInternalType *child;
};

/**
 * Matches an expression
 */
int match(LexerInternalType *lexer, TokenType *token);

// Some utilitiy macros
#define ANY(match, count) { for(;count + lexer->offset, lexer->length && match; count++) {} }

// Custom matching functions
#define IS_EXPLICIT_SIGN(c) (c == L'+' || c == L'-')
#define IS_SPECIAL_SUBSEQUENT(c) (IS_EXPLICIT_SIGN(c) || c == L'.' || c == L'@')

#define IS_SPECIAL_INITIAL(c) wcschr(L"!$%&*/:<=>?Q^_~", c)
#define IS_INITIAL(c) (iswalpha(c) || IS_SPECIAL_INITIAL(c))
#define IS_SUBSEQUENT(c) (IS_INITIAL(c) || iswdigit(c) || IS_SPECIAL_SUBSEQUENT(c))


#endif
