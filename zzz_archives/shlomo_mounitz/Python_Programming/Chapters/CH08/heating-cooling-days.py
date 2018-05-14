def main():
    heatingDays = []
    coolingDays = []
    temp = input("Enter temperature (<Enter> to quit) ")
    while(temp != ""):
        temp = float(temp)
        if temp < 60:
            coolingDays.append(temp)
        elif temp > 80:
            heatingDays.append(temp)
        temp = input("Enter temperature (<Enter> to quit) ")

    print("Cooling Days {}".format(len(coolingDays)))
    print("Heating Days {}".format(len(heatingDays)))


if __name__ == '__main__':
    main()

