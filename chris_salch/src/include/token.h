#ifndef _TOKEN_
#define _TOKEN_

typedef void LexerType;
typedef struct Token TokenType;

typedef enum {
    WHITESPACE_TOKEN = 0,
    IDENTIFIER_TOKEN,
    
    TRUE_TOKEN,
    FALSE_TOKEN,

    S_START_TOKEN,
    S_END_TOKEN,

    VECTOR_START_TOKEN,
    BYTE_VECTOR_START_TOKEN,

    QUOTE_TOKEN,

    BAD_TOKEN
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
 * Return the next token from the given lexer
 *
 */
TokenType *getTokenLexer(LexerType *lexer);

/**
 * Dump a token to stdout 
 *
 */
void outputTokenLexer(LexerType *lexer, TokenType *token);

#endif
