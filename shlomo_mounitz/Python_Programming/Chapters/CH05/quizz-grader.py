def main():
    grades = ['A','B','C','D','F','F']
    score = int(input('Enter score: '))
    print("The grade is {}".format(grades[len(grades) - score - 1]))

main()