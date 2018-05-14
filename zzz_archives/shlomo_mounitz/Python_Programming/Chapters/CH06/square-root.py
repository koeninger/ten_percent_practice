def nextGuess(guess, x):
    return (guess + x / guess) / 2

def sqr(x, times):
    guess = x / 2
    for i in range(times):
        guess = nextGuess(guess, x)
    return guess

def main():
    print("This program calculates the square root of a number ")
    x = float(input("Enter number"))
    accuracy  = int(input("Accuracy the higher the better "))
    print(sqr(x, accuracy))

if __name__ == '__main__':
    main()
