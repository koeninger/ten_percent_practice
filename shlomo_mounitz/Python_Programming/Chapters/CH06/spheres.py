import math

def sphereArea(radius):
    return  4 * math.pi * radius ** 2

def sphereVolume(radius):
    return  4/3 * math.pi * radius ** 3

def main():
    print("This program calculates the volume and surface area of a sphere")
    radius = int(input("What is the sphere radius? "))
    volume = sphereVolume(radius)
    area = sphereArea(radius)
    print ("volume: {} \t surface area: {}".format(volume,area))

main()