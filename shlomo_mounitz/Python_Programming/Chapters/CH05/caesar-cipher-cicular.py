# This program encode and decodes a string with a caesar cipher

def main():
    inputString = input("Input String: ")
    key = int(input("Key (to decode use negative key): "))
    outputString = ''
    for ch in inputString:
        val = (ord(ch) - 32 + key) % 127 
        outputString += chr(val + 32)
    print("Output String: {}".format(outputString))
main()