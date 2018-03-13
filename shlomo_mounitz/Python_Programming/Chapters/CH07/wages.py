def calculate(hours, rate):
    
    hoursPerWeek = 40
    wage = 0

    if (hours > hoursPerWeek):
        overtime = hours - hoursPerWeek
        wage = overtime * 1.5 * rate
        hours = hoursPerWeek
    wage += hours * rate
    return wage

def main():
    hours = int(input("Hours worked: "))
    rate = int(input("Rate: "))
    wage = calculate(hours, rate)
    print("The wages is: {}".format(wage))

if __name__ == '__main__':
    main()
