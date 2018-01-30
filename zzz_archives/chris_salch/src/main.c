#include <core.h>

#include <fcntl.h>
#include <sys/stat.h>
#include <sys/mman.h>

#include <token.h>

void usage(char *name)
{
    fprintf(stderr, "Usage: %s <file.scm>\n\n", name);
    exit(-1);
}

/**
 * Read the given file into memory completely. The caller is responsibe for
 * deallocating memory 
 *
 */
size_t slurp(char * fileName, char **outBuffer)
{
    struct stat fileStat;
    int fd = open(fileName, O_RDONLY);

    fstat(fd, &fileStat);

    size_t size = fileStat.st_size;
    
    void * file = mmap(NULL, size, PROT_READ, MAP_FILE | MAP_SHARED, fd, 0);

    char * buf = malloc(size + 1);
    bzero(buf, size + 1);

    memcpy(buf, file, size);
    munmap(file, size);

    // update the output buffer 
    *outBuffer = buf;
    
    // return the size of data that we loaded
    return size;
}

int main(int argc, char**argv)
{
    char *buf = 0;
    size_t size = 0;
    TokenType *token = 0;

    /* Make sure that we have a passed in file */
    if (argc < 2) {
        usage(argv[0]);
    }

    // make sure that the locale is configured
    setlocale(LC_ALL, "");
    
    // Slurp the file
    size = slurp(argv[1], &buf);

    // Create a lexer so we can get a token stream
    LexerType * lexer = createLexer(buf, size);

    while ((token = getTokenLexer(lexer))) {
        outputTokenLexer(lexer, token);
    }

    // clena up 
    destroyLexer(lexer);
    return 0;
}
