#include <lexer_internal.h>

MATCH_SINGLE(SStart, L'(', S_START_TOKEN)
MATCH_SINGLE(SEnd, L')', S_END_TOKEN)
MATCH_SINGLE(Quote, L'`', QUOTE_TOKEN)

MATCH_STRING(VectorStart, L"#(", 2, VECTOR_START_TOKEN)
MATCH_STRING(ByteVectorStart, L"#u8(", 4, BYTE_VECTOR_START_TOKEN)

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


int matchBoolean(LexerInternalType *lexer, TokenType *token)
{
    if (subStringCmpToken(L"#true", token)) {
        token->type = TRUE_TOKEN;
        token->length = 5;
        return 1;
    }

    if (subStringCmpToken(L"#t", token)) {
        token->type = TRUE_TOKEN;
        token->length = 2;
        return 1;
    }

    if (subStringCmpToken(L"#false", token)) {
        token->type = FALSE_TOKEN;
        token->length = 6;
        return 1;
    }

    if (subStringCmpToken(L"#f", token)) {
        token->type = FALSE_TOKEN;
        token->length = 2;
        return 1;
    }

    return 0;
}

int match(LexerInternalType *lexer, TokenType *token)
{
    return matchWhitespace(lexer, token) ||
        matchIdentifier(lexer, token) || 
        matchBoolean(lexer, token) ||
        matchSStart(lexer, token) ||
        matchSEnd(lexer, token) ||
        matchVectorStart(lexer, token) ||
        matchByteVectorStart(lexer, token); 
}
