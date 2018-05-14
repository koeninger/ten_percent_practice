# this program prompts the user to enter a phrase and returns an acronym

def main():
    words = input("Enter a phrase ")
    acronym = ''
    for w in words.split():
        acronym += w[:1]
    print("The acronym is {}".format(acronym.upper()))
main()