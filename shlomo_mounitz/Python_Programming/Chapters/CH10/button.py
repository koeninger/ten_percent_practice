from graphics import *

class Button:
    def __init__(self, win, ll, ur, text):
        self.win = win
        self.ll = ll
        self.ur = ur
        self.drawButton()

    def drawButton(self):
        self.r = Rectangle(self.ll, self.ur)
        self.r.draw(self.win)
        
    def checkBounds(self,p):
        if p.getX() < self.r.getP1().getX():
            return False
        if p.getX() > self.r.getP2().getX():
            return False
        if p.getY() < self.r.getP1().getY():
            return False
        if p.getY() > self.r.getP2().getY():
            return False
        return True

def main():
    win = GraphWin()
    win.setCoords(0,0,10,10)
    b = Button(win, Point(9,1), Point(10,2),'test')
    win.getMouse()
    win.close()


if __name__ == '__main__':
    main()