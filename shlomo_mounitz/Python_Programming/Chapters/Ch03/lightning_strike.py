
def main():
    print("This program calculates thedistance to a lightning strike.")
    seconds = int(input("Seconds elapsed between the flash and sound? "))
    feet = seconds * 1100
    miles = feet / 5280
    print ("The lightning strike was approximately {} miles away".format(miles))

main()