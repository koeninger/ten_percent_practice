#include <stdio.h>
#include <inttypes.h>

#include <token.h>

#include <lexer_internal.h>

LexerType * createLexer(const char *buf, off_t size)
{
    printf("Size: %" PRIu64 " Buffer: %p\n", size, (void *)buf);


    return 0;
}

void destroyLexer(LexerType * lexer)
{

}

Token *getTokenLexer(LexerType *lexer)
{
    return 0;
}
