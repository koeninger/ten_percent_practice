import math

def main():
    print("This program calculates the volume and surface area of a sphere")
    radius = int(input("What is the sphere radius? "))
    volume = 4/3 * math.pi * radius ** 3
    area = 4 * math.pi * radius ** 2
    print ("volume: {} \t surface area: {}".format(volume,area))

main()