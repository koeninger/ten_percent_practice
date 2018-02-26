def main():
    print("This program converts temperatures from Celsius to Fahrenteit")
    for i in range(5):
        celsius = eval(input("What is the Celsius temperature? "))
        fahrenheit = 9/5 * celsius + 32
        print("The temperature is {} degrees Fahrenheit".format(fahrenheit))
    input("\nPress <enter> to quit")

main()