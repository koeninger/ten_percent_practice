def main():
    print("This program calculates the nth Fibonacci number.")
    nth = int(input("Which nth? "))
    
    n1 = 0
    n2 = 0
    n3 = 1
    
    for i in range(1,nth):
        n1 = n2
        n2 = n3
        n3 = n1 + n2

    print(n3)

main()