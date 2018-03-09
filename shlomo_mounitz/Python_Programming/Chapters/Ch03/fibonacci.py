def main():
    print("This program calculates the nth Fibonacci number.")
    nth = int(input("Which nth? "))
    
    n1 = 1
    n2 = 1
    n3 = 2
    
    for i in range(3,nth):
        n1 = n2
        n2 = n3
        n3 = n1 + n2

    print(n3)

main()