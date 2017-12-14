#include <lexer_internal.h>

LexerType * createLexer(const char *buf, size_t size)
{
    LexerInternalType *lexer = 0;
    wchar_t *wideBuf = 0;

    lexer = (LexerInternalType *)calloc(sizeof(LexerInternalType), 1);

    // We will always have at most size wc characters and probably less
    wideBuf = (wchar_t *)calloc(sizeof(wchar_t), size + 1);
    lexer->length = mbstowcs(wideBuf, buf, size + 1);

    lexer->buf = wideBuf;

    attachMatchers(lexer);

    return (LexerType *)lexer;
}

void destroyLexer(LexerType * lexerRaw)
{   
    LexerInternalType *lexer = (LexerInternalType *)lexerRaw;
    TokenType *token = lexer->tokenHead;
    TokenType *next = 0;

    // Free all the tokens
    while (token) {
        next = token->next;
        free(token);
        token = next;
    }

    free((void *)lexer->buf);
    free(lexer);
}

TokenType *getTokenLexer(LexerType *lexerRaw)
{
    TokenType * token = 0;
    LexerInternalType *lexer = (LexerInternalType *)lexerRaw;
    size_t left = lexer->length - lexer->offset;

    // We're done!
    if (left <= 0) {
        return 0;
    }

    token = (TokenType *)calloc(sizeof(TokenType), 1);
    token->content = lexer->buf + lexer->offset;

    // match this token
    for (int i = 0; i < END_TOKEN_LIST; i++) {
        if (lexer->matchers[i](lexer, token)) {
            break;
        }
    }


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
