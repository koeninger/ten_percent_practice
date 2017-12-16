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
    token->length = left;

    // Make sure that the we can match a token 
    assert(match(lexer, token));

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


void outputTokenLexer(LexerType *lexerRaw, TokenType *token)
{
    wchar_t outputBuff[token->length + 1];
    bzero(outputBuff, sizeof(outputBuff));
   
    wcsncpy(outputBuff, token->content, token->length);

    printf("Token: %i Size: %4.zu Content: %S\n", token->type, token->length, outputBuff);

}

wchar_t peekCharToken(TokenType *token, size_t offset)
{
    if (offset > token->length) {
        return 0;
    }

    return token->content[offset];
}

int subStringCmpToken(const wchar_t *expect, TokenType *token)
{
    size_t length = wcslen(expect);
    wchar_t c = 0;

    for (size_t i = 0; i < length && (c = peekCharToken(token, i)); i++) {
        if (c != expect[i]) {
            return 0;
        }
    }

    return 1;
}
