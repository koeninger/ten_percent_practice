#!/usr/bin/env python

class Parent():

    def __init__(self, name, eye_color):

        print("Parent Constructor Called")
        self.name = name
        self.eye_color = eye_color

    def show_info(self):
        print("Name: "+self.name)
        print("Eye Color: "+self.eye_color)

# class Child will inherit all variables, methods, etc. from class Parent
class Child(Parent):

    def __init__(self, name, eye_color, number_of_toys):
        print("Child Constructor Called")
        Parent.__init__(self, name, eye_color)
        self.number_of_toys = number_of_toys

    # demonstration of method overriding
    def show_info(self):
        print("Name: "+self.name)
        print("Eye Color: "+self.eye_color)
        print("# of Toys: "+str(self.number_of_toys))

billy = Parent("Billy", "blue")
print(billy.name)

miley = Child("Miley", "Blue", 5)
print(miley.eye_color)

billy.show_info()
miley.show_info()
