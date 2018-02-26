# a program to compute the value of an investment

def main():
    print("This program calculates the future value of an investment")
    principal = eval(input("Initial principal: "))
    apr = eval(input("Yearly rate: "))
    periods = eval(input("Periods per year: "))
    years = eval(input("years: "))

    for i in range(years * periods):
        principal = principal * (1 + apr / periods)
    

    print("The value in {} years is: {}".format(years, principal))
    
main()