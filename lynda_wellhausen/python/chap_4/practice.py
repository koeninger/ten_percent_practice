def less_than_five():
    a = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
    for value in a:
        if value < 5:
            print(value, "is less than", 5)
        else:
            pass

# >>> less_than_five()
# (1, 'is less than', 5)
# (1, 'is less than', 5)
# (2, 'is less than', 5)
# (3, 'is less than', 5)