# This program calculates the numeric value of names

def main():
    name = input('Enter name: ')
    name = name.replace(' ', '')
    name = name.upper()
    numericValue = 0
    for ch in name:
        numericValue = numericValue + ord(ch) - ord('A') + 1
    print("The numeric value is: {}".format(numericValue))
    
main()
