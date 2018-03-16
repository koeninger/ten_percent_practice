def calculate(temp, windMPH):
    if windMPH <= 3:
        return temp
    return 35.74 + 0.6215 * temp - 35.75 * (windMPH ** 0.16) + 0.4275 * temp * (windMPH ** 0.16)

def main():
    print("\t\t", end="")
    for temp in range (-20, 60, 10):
        print ('{:5} F'.format(temp), end="\t")
    for windSpeed in range(0, 50, 5):
        print("\n")
        print ('{:5} MPH'.format(windSpeed), end="\t")
        for temp in range (-20, 60, 10):
            print('{:^3.2f}'.format(calculate(temp, windSpeed)), end="\t")
    print("\n\n")
        
if __name__ == '__main__':
    main()