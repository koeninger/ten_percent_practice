#include <stdio.h>
#include <inttypes.h>

#include <token.h>

#include <lexer_internal.h>

LexerType * createLexer(const char *buf, size_t size)
{
    printf("Size: %zu Buffer: %p\n", size, (void *)buf);


    return 0;
}

void destroyLexer(LexerType * lexer)
{

}

Token *getTokenLexer(LexerType *lexer)
{
    return 0;
}
