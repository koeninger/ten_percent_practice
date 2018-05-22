# This program encode and decodes a string with a caesar cipher

def main():
    inputString = input("Input String: ")
    key = int(input("Key: "))
    outputString = ''
    for ch in inputString:
        outputString += chr(ord(ch) + key)
    print("Output String: {}".format(outputString))
main()