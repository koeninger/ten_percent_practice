def years_to_100:
    name = input("give me your name: ")
    print("your name is " + name)
    age = int(input("enter your age:"))
    year_100 = (100 - age) + 2017
    print( "you will turn 100 in" + year_100 + "," + name )

def even_odd: 
    number = int("input a number")
    remainder = number % 2
    if remainder > 0
        print("number is odd")
    if remainder == 0
        print("number is even")