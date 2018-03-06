def main():
    grades = ['A', 'A', 'B','C','D','F','F','F','F','F']
    score = input('Enter score: ')
    score = int(score[:-1])
    print("The grade is {}".format(grades[len(grades) - score ]))

main()