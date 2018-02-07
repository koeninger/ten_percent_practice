#!/usr/bin/env python

import time
import webbrowser

x=1
print("This program started at {0}".format(time.ctime()))
while x<=3:
    time.sleep(3)
    webbrowser.open("http://www.youtube.com/watch?v=dQw4w9WgXcQ")
    x = x+1
