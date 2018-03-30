
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
    if len(string) == 0:
        return string
    return string_reverse(string[1:]) + string[0]
print string_reverse('POIUYTREWQ');

# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #