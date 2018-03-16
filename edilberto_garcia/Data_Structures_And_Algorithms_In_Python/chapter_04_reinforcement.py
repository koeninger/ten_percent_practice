
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
    
    if min_or_max == 'min':
    	return min(sequence[len(sequence)-1], minmax(sequence, sequence[len(sequence)-1]));
    elif min_or_max == 'max':
    	return max(sequence[len(sequence)-1], minmax(sequence, sequence[len(sequence)-1]));


print minmax([1,2,3,4,5,6,7,8,9,10,2000,4343,-2,23,607607,30], 'max')



# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #