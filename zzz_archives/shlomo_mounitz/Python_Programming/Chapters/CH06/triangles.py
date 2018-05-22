import math

def area(a, b, c):
    s = ( a + b + c) / 2
    return math.sqrt(s * (s - a) * (s - b) * (s - c))
     
def main():
    print("This program calculates the area of a triangle")
    a = int(input("Length of side A? "))
    b = int(input("Length of side B? "))
    c = int(input("Length of side C? "))

    print ("Area: {} ".format(area(a, b, c)))

main()