#ifndef _TOKEN_
#define _TOKEN_

typedef void LexerType;
typedef void Token;

/**
 * Create a lexer instance reading from the passed in character buffer. 
 *
 */
LexerType *createLexer(char *buf);

/**
 * return the next token from the given lexer
 *
 */
Token *lexerNext(LexerType *lexer);

#endif
