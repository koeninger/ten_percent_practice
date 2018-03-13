from datetime import datetime

def calc(seconds, ratePerHour):
    return seconds * ratePerHour / 3600

def calcRate(startTime, endTime):
    rate = 0
    night = datetime.strptime('9:00PM','%I:%M%p')
    if (endTime > night ):
        rate += calc((night - startTime).seconds, 2.50)
        rate += calc((endTime - night).seconds,1.75)
    else:
        rate += calc((endTime - startTime).seconds, 2.50)
    return rate

def main():
    print("This program calculates the babysitter rate")
    startTime = datetime.strptime(input("Start Time (ex 8:00PM): "),'%I:%M%p')
    endTime = datetime.strptime(input("End Time (ex 11:30PM): "),'%I:%M%p')
    rate = calcRate(startTime, endTime)
    print("Rate ${:,.2f}".format(rate))

if __name__ == '__main__':
    main()
