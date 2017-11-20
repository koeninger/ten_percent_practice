#include <stdio.h>
#include <stdlib.h>

#include <token.h>

void usage(char *name)
{
    fprintf(stderr, "Usage: %s <file.scm>\n\n", name);
    exit(-1);
}

int main(int argc, char**argv)
{

    /* Make sure that we have a passed in file */
    if (argc < 2) {
        usage(argv[0]);
    }

    LexerType * lexer = createLexer("");


    return 0;
}
