
# R-4.1 Describe a recursive algorithm for finding the maximum element in a sequence,
# S, of n elements. What is your running time and space usage?


# *************************************************** #
# 


# C-4.9 Write a short recursive Python function that finds the minimum and maximum
# values in a sequence without using any loops.

def minmax(sequence, min_or_max):

    print 'sequence: ', sequence
    # if size = 0 means whole array has been traversed
    if (len(sequence) == 1):
        return sequence[0];
    
    num = minmax(sequence[1:], min_or_max)

    if min_or_max == 'min':
        if num < sequence[0]:
            return num
        else:
            return sequence[0]
    elif min_or_max == 'max':
        if num > sequence[0]:
            return num
        else:
            return sequence[0]

# print minmax([1,2,3,4,5,6,7,8,9,10,2000,4343,-2,23,607607,30], 'max')

# *************************************************** #

# C-4.12 Give a recursive algorithm to compute the product of two positive integers,
# m and n, using only addition and subtraction.

def product(a,b):
    print 'a: ', a, 'b', b
    if (b > 1):
        a += product(a, b - 1)
    return a

# print product(13,5)

# C-4.16 Write a short recursive Python function that takes a character string s and
# outputs its reverse.

def string_reverse(string):
    # if len(string) > 0:
        # print "String in this iteration: ", string, "\n\tWhat we're passing in here", string[1:], "\n\tstring[0]:", string[0]
    if len(string) == 0:
        return string
    return string_reverse(string[1:]) + string[0]
# print string_reverse('POIUYTREWQ');

# *************************************************** #

# C-4.17 Write a short recursive Python function that determines if a string s is a
# palindrome, that is, it is equal to its reverse. For example, racecar and
# gohangasalamiimalasagnahog are palindromes.


def rec_is_palindrome(string):
    if len(string) == 1:
        return True
    if string[0] != string[-1]:
        return False

    print 'rec_is_palindrome(',string[1:-1],')'
    return rec_is_palindrome(string[1:-1])

# print rec_is_palindrome('race4car'), rec_is_palindrome('madamimadam')

# *************************************************** #

# C-4.18 Use recursion to write a Python function for determining if a string s has
# more vowels than consonants.

def recursive_has_more_vowels(string, vowels = [], consonants = []):
    # taking advantage of the python parameter caching hack
    if len(string) <= 1:
        return False
    
#todo: finish this
# print recursive_has_more_vowels('F')


# *************************************************** #

# C-4.19 Write a short recursive Python function that rearranges a sequence of integer values 
# so that all the even values appear before all the odd values.

def recursive_evens_before_odds(sequence):
    if len(sequence) <= 1:
        return sequence

    midpoint = len(sequence) / 2
    recursive_evens_before_odds(sequence)
    recursive_evens_before_odds(sequence + midpoint)
    print 'Recursion ended, list: => ', sequence

recursive_evens_before_odds([1,2,4,57,8,9,3,2,6,8,4,8,9])

# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #