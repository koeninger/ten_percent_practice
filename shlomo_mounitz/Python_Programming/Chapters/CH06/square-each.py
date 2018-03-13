def squareEach(list):
    c = 0
    for e in list:
        list[c] = e ** 2
        c = c + 1
    return list

def main():
    list = squareEach([2,4,6])
    print (list)
main()