#ifndef _TOKEN_
#define _TOKEN_

typedef void LexerType;
typedef struct Token TokenType;

typedef enum {
    IDENTIFIER_TOKEN = 0, // must be first
    WHITESPACE_TOKEN,

    BAD_TOKEN,

    // Must be last entry
    END_TOKEN_LIST
} SchemeToken;

struct Token {
    SchemeToken type;
    const wchar_t *content; // actual content of the current token 
    size_t length; // the length of the current token

    TokenType *next; // the next token in a stream
};


/**
 * Create a lexer instance reading from the passed in character buffer. 
 *
 */
LexerType *createLexer(const char *buf, size_t size);

/**
 * Destory a lexer instance and clean up any allocated memory
 *
 */
void destroyLexer(LexerType *lexer);

/**
 * return the next token from the given lexer
 *
 */
TokenType *getTokenLexer(LexerType *lexer);

#endif
