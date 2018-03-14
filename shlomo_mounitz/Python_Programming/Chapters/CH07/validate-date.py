def isLeapYear(year):
    if year % 4 == 0 and year % 100 != 0:
        return True
    if year % 400 == 0:
        return True
    return False

def has30days(month):
    if month in[4, 6, 9, 11 ]:
        return True
    return False

def validate(day, month, year):
    if month < 1 or month > 12:
        return False    
    if day < 1:
        return False
    if has30days(month) and day > 30:
        return False
    elif day > 31:
        return False
    if month == 2 and day > 28 and not isLeapYear(year):
        return False
    elif month == 2 and day > 29:
        return False

    return True


def main():
    print("This program validates a date (ex: 6/18/1812) ")
    dateStr = input("date: ")
    month, day, year = dateStr.split('/')
    results = validate(int(day), int(month), int(year))
    if results:
        print("valid")
    else:
        print("invalid")


if __name__ == '__main__':
    main()
