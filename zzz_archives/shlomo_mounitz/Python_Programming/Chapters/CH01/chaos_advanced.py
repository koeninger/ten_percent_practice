def main():
    print("This program illustrates a chaotic function")
    s1 = eval(input("Enter a number between 0 and 1: "))
    s2 = eval(input("Enter a number between 0 and 1: "))
    n = eval(input("How many rows should I print: "))
    print('{}\t\t\t\t{}'.format(s1, s2))
    print("--------------------------------------")
    for i in range(n):
        s1 = 3.9 * s1 * (1-s1)
        s2 = 3.9 * s2 * (1-s1)
        print('{}\t\t\t\t{}'.format(s1, s2))

main()