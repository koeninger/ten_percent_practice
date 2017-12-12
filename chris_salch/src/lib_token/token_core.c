#include <stdio.h>
#include <inttypes.h>

#include <token.h>

#include <lexer_internal.h>

LexerType * createLexer(const char *buf, size_t size)
{
    LexerInternalType *lexer = 0;

    lexer = (LexerInternalType *)calloc(sizeof(LexerInternalType), 1);

    lexer->buf = buf;
    lexer->length = size;

    lexer->tokenHead = 0;
    lexer->tokenTail = 0;

    lexer->child = 0;

    return (LexerType *)lexer;
}

void destroyLexer(LexerType * lexer)
{
    TokenType *token = ((LexerInternalType *)lexer)->tokenHead;
    TokenType *next = 0;

    // Free all the tokens
    while (token) {
        next = token->next;
        free(token);
        token = next;
    }

    free(lexer);
}

TokenType *getTokenLexer(LexerType *lexerRaw)
{
    TokenType * token = 0;
    LexerInternalType *lexer = (LexerInternalType *)lexerRaw;
    size_t left = lexer->length - lexer->offset;
    char *c = 0;

    // We're done!
    if (left <= 0) {
        return 0;
    }

    token = (TokenType *)calloc(sizeof(TokenType), 1);

    c = lexer->buf + lexer->offset;
    token->length = mbtowc(&(token->content), c, left);

    assert(token->length > 0);
    

    lexer->offset += token->length;

    if (lexer->tokenHead == 0) {
        lexer->tokenHead = token;
        lexer->tokenTail = token;
    } else {
        lexer->tokenTail->next = token;
        lexer->tokenTail = token;
    }

    return token;
}
