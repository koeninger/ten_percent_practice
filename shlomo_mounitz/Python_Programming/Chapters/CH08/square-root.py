def nextGuess(guess, x):
    return (guess + x / guess) / 2

def sqr(x):
    guess = x / 2
    while abs(x - guess ** 2) > 0.00001:
        guess = nextGuess(guess, x)
    return guess

def main():
    print("This program calculates the square root of a number ")
    x = float(input("Enter number "))
    print(sqr(x))

if __name__ == '__main__':
    main()
