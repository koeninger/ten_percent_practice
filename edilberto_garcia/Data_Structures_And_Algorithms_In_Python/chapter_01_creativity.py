# C-1.13 Write a pseudo-code description of a function that reverses a list of n
# integers, so that the numbers are listed in the opposite order than they
# were before, and compare this method to an equivalent Python function
# for doing the same thing.

	#Pseudocode reverse
	# reverse(list)
	# 	ret_val = []
	# 	for i = list.length; i >= 0 ; i--
	# 		ret_val.append(list[i])
	# 	return ret_val

	# The python function to reverse a list is reverse(). 
	# Don't know the algorithm for it but it is probably more optimized than mine

# *************************************************** #

# C-1.14 Write a short Python function that takes a sequence of integer values and
# determines if there is a distinct pair of numbers in the sequence whose
# product is odd.

def has_distinct_pair(sequence):
	enumarated = enumerate(sequence)
	for i, num in enumarated:
		for j, sub_num in enumarated:
			if i == j or num == sub_num:
				continue
			if (num * sub_num) % 2 == 1:
				return (num, sub_num)
	return False
# print has_distinct_pair([1,2,3,4,5,6,7,8,9])

# *************************************************** #

# C-1.15 Write a Python function that takes a sequence of numbers and determines
# if all the numbers are different from each other (that is, they are distinct).

def is_sequence_unique(sequence):
	return len(sequence) == len(set(sequence))
# print is_sequence_unique([1,2,34,66,3,4,57,8,54,78,457,7,342,6464,764])

# *************************************************** #

# C-1.16 In our implementation of the scale function (page 25), the body of the loop
# executes the command data[j] = factor. We have discussed that numeric
# types are immutable, and that use of the = operator in this context causes
# the creation of a new instance (not the mutation of an existing instance).
# How is it still possible, then, that our implementation of scale changes the
# actual parameter sent by the caller?





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
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #