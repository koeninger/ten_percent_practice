#!/usr/bin/env python

##################
#  create a geodesic design from repeating squares
##################

import turtle

def draw_square(some_turtle):
    for i in range (1, 5):
        some_turtle.forward(100)
        some_turtle.right(90)

def draw_art():
    window = turtle.Screen()
    window.bgcolor("red")
    brad = turtle.Turtle()
    brad.shape("turtle")
    brad.color("yellow")
    brad.speed(0)

    i = 0
    degree = 1
    while i <= 360:  
        draw_square(brad)
        brad.right(degree)
        i = i + degree

    window.exitonclick()

draw_art()
