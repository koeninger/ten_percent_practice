from graphics import *

def main():
    win = GraphWin("Regression Line")
    win.setCoords(0,0,10,10)
    r = drawButton(win, Point(9,1), Point(10,2))
    while True:
        point = win.getMouse()
        if checkBounds(point, r):
            break
        point.draw(win)
    win.close()

def drawButton(win, ll, ur):
    r = Rectangle(ll, ur)
    r.draw(win)
    return r

def checkBounds(p, r):
    if p.getX() < r.getP1().getX():
        return False
    if p.getX() > r.getP2().getX():
       return False
    if p.getY() < r.getP1().getY():
        return False
    if p.getY() > r.getP2().getY():
       return False
    return True

if __name__ == '__main__':
    main()