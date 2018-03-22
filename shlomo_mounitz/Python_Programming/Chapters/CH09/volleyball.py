from random import random

def simOneGame(probA, probB):
    serving = "A"
    scoreA = 0
    scoreB = 0
    while scoreA < 15 and scoreB < 15:
        if serving == "A":
            if random() < probA:
                scoreA = scoreA + 1
            else:
                serving = "B"
        else:
            if random() < probB:
                scoreB = scoreB + 1
            else:
                serving = "A"
    return scoreA, scoreB

def main():
    scoreA, scoreB = simOneGame(.7, .6)
    print("player A: {} \t player B: {}".format(scoreA, scoreB))
if __name__ == '__main__':
    main()