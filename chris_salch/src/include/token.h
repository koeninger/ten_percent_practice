#ifndef _TOKEN_
#define _TOKEN_

typedef void LexerType;
typedef void Token;

/**
 * Create a lexer instance reading from the passed in character buffer. 
 *
 */
LexerType *createLexer(const char *buf, off_t size);

/**
 * Destory a lexer instance and clean up any allocated memory
 *
 */
void destroyLexer(LexerType *lexer);

/**
 * return the next token from the given lexer
 *
 */
Token *getTokenLexer(LexerType *lexer);

#endif
