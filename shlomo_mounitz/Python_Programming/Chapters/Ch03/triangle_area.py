import math

def main():
    print("This program calculates the area of a triangle")
    a = int(input("Length of side A? "))
    b = int(input("Length of side B? "))
    c = int(input("Length of side C? "))
    
    s = ( a + b + c) / 2
    area = math.sqrt(s * (s - a) * (s - b) * (s - c))

    print ("Area: {} ".format(area))

main()