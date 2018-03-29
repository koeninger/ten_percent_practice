from graphics import *

def main():
    win = GraphWin("Regression Line")
    win.setCoords(0,0,10,10)
    r = drawButton(win, Point(9,1), Point(10,2))
    count = 0
    xTotal = 0
    yTotal = 0
    xyTotal = 0
    xSqTotal = 0
    ySqTotal = 0

    while True:
        point = win.getMouse()

        if checkBounds(point, r):
            break
        point.draw(win)
        count = count +1
        xTotal = xTotal + point.getX()
        yTotal = yTotal + point.getY()
        xyTotal = xyTotal + point.getX() * point.getY()
        xSqTotal = xSqTotal + point.getX() * point.getX()
        ySqTotal = ySqTotal + point.getY() * point.getY()
    
    t = Text(Point(2,2), getY(count, xTotal, yTotal, xyTotal, xSqTotal, ySqTotal))
    t.draw(win)
    win.getMouse()
    win.close()

def getY(count, xTotal, yTotal, xyTotal, xSqTotal, ySqTotal):
    return (count * xyTotal - xTotal * yTotal) / (count * xSqTotal - xTotal * xTotal) * (count * ySqTotal - yTotal * yTotal)

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