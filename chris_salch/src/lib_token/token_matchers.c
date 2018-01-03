#include <lexer_internal.h>

MATCH_SINGLE(SStart, L'(', S_START_TOKEN)
MATCH_SINGLE(SEnd, L')', S_END_TOKEN)
MATCH_SINGLE(Quote, L'\'', QUOTE_TOKEN)

MATCH_SINGLE(Quasiquote, L'`', QUASIQUOTE_TOKEN)
MATCH_SINGLE(Comma, L',', COMMA_TOKEN)
MATCH_STRING(CommaAt, L",@", 2, COMMA_AT_TOKEN)

MATCH_SINGLE(Dot, L'.', DOT_TOKEN)

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

MATCH_STRING(LongTrue, L"#true", 5, TRUE_TOKEN)
MATCH_STRING(ShortTrue, L"#t", 2, TRUE_TOKEN)
MATCH_STRING(LongFalse, L"#false", 6, FALSE_TOKEN)
MATCH_STRING(ShortFalse, L"#f", 2, FALSE_TOKEN)

int matchBoolean(LexerInternalType *lexer, TokenType *token)
{
    return
        matchLongTrue(lexer, token) ||
        matchLongFalse(lexer, token) ||
        matchShortTrue(lexer, token) ||
        matchShortFalse(lexer, token);
}

MATCH_SINGLE(N, L'\n', LINE_ENDING_TOKEN)
MATCH_SINGLE(R, L'\r', LINE_ENDING_TOKEN)
MATCH_STRING(RN, L"\r\n", 2, LINE_ENDING_TOKEN)

int matchLineEnding(LexerInternalType *lexer, TokenType *token)
{
    return
        matchN(lexer, token) ||
        matchRN(lexer, token) ||
        matchR(lexer, token);
        
}

int match(LexerInternalType *lexer, TokenType *token)
{
    return 
        matchLineEnding(lexer, token) ||
        matchWhitespace(lexer, token) ||
        matchIdentifier(lexer, token) || 
        matchBoolean(lexer, token) ||
        matchSStart(lexer, token) ||
        matchSEnd(lexer, token) ||
        matchVectorStart(lexer, token) ||
        matchByteVectorStart(lexer, token) ||
        matchQuote(lexer, token) ||
        matchQuasiquote(lexer, token) ||
        matchCommaAt(lexer, token) || // must come before comma
        matchComma(lexer, token) ||
        matchDot(lexer, token); 
}
