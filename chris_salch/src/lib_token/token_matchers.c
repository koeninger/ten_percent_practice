#include <lexer_internal.h>

int matchIdentifier(LexerInternalType *lexer, TokenType *token)
{
    size_t length = 0;
    const wchar_t *content = token->content;

    // Check initial character
    if (!IS_INITIAL(content[0])) {
        return 0;
    }
    
    length++;
    
    // eat characters until we find one we can't match
    ANY(IS_SUBSEQUENT(content[length]), length);

    //for (;length + lexer->offset < lexer->length && IS_SUBSEQUENT(content[length]); length++ ) {
    //}

    token->type = IDENTIFIER_TOKEN; 
    token->length = length;

    return 1;
}

int matchWhitespace(LexerInternalType *lexer, TokenType *token)
{
    size_t length = 0;

    ANY(iswspace(token->content[length]), length)

    if (length) {
        token->type = WHITESPACE_TOKEN;
        token->length = length;
    }

    return length > 0;
}


int match(LexerInternalType *lexer, TokenType *token)
{
    return matchWhitespace(lexer, token) ||
        matchIdentifier(lexer, token); 
}
