from graphics import *

def main():
    win = GraphWin('Target');
    win.setCoords(-10,-10, 10, 10)
    center = Point(0,0)
    colors = ['yellow','red','blue','black','white']
    for i in range(len(colors),0,-1):
        circle = Circle(center,i)
        circle.setFill(colors[i-1])
        circle.draw(win)
    win.getMouse()

main()