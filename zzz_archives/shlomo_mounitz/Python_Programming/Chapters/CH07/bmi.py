
def calculateBodyMassIndex(weight, height):
    return (weight * 720) / height ** 2

def  evaluateBMI(bmi):
    if bmi < 19:
        return "below"
    elif bmi <= 25:
        return "within"
    else:
        return "above"

def main():
    print("This program calculates the Body Mass Index.")
    weight = int(input("weight in pounds: "))
    height = int(input("height in inches: "))
    bmi = calculateBodyMassIndex(weight, height)
    result = evaluateBMI(bmi)
    print("Body Mass Index {0:.2f} is {1} the healthy range".format(bmi, result))

if __name__ == '__main__':
    main()
