def main():
    heatingDays = []
    coolingDays = []
    fileName = input("File with temperatures: ")
    infile = open(fileName, 'r')
    for line in infile:
        try:
            temp = float(line)
        except ValueError:
            pass
        if temp < 60:
            coolingDays.append(temp)
        elif temp > 80:
            heatingDays.append(temp)
        
    infile.close()
    print("Cooling Days {}".format(len(coolingDays)))
    print("Heating Days {}".format(len(heatingDays)))


if __name__ == '__main__':
    main()

