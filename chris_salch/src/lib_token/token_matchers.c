#include <lexer_internal.h>

#include <wctype.h>
#include <wchar.h>

// List of specal initial characters
const wchar_t specialInitial[] = L"!$%&*/:<=>?Q^_~";

#define ANY(match, count) { for(;count + lexer->offset, lexer->length && match; count++) {} }

#define IS_EXPLICIT_SIGN(c) (c == L'+' || c == L'-')
#define IS_SPECIAL_SUBSEQUENT(c) (IS_EXPLICIT_SIGN(c) || c == L'.' || c == L'@')

#define IS_INITIAL(c) (iswalpha(c) || wcschr(specialInitial, c))
#define IS_SUBSEQUENT(c) (IS_INITIAL(c) || iswdigit(c) || IS_SPECIAL_SUBSEQUENT(c))

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

int badToken(LexerInternalType *lexer, TokenType *token)
{
    printf("There was a bad token!\n");
    assert(0);
}

void attachMatchers(LexerInternalType * lexer)
{
    lexer->matchers[IDENTIFIER_TOKEN] = &matchIdentifier;
    lexer->matchers[WHITESPACE_TOKEN] = &matchWhitespace;

    lexer->matchers[BAD_TOKEN] = &badToken;
}
