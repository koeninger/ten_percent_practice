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

	# def scale(data, factor):
	# 	for j in range(len(data)):
	# 		data[j] *= factor

	# Lists are mutable in Python, if this were an immutable type passed in,
	# you would get an altered copy of the original

# *************************************************** #

# C-1.17 Had we implemented the scale function (page 25) as follows, does it work
# properly?
# 	def scale(data, factor):
# 		for val in data:
# 			val *= factor
# Explain why or why not.
	
	# This would not work as you are now altering an int and not the list itself
	
# *************************************************** #

# C-1.18 Demonstrate how to use Python's list comprehension syntax to produce
# the list [0, 2, 6, 12, 20, 30, 42, 56, 72, 90].

	# index * (index + 1)
	# [ n * (n+1) for n in range(0, 10)]

# *************************************************** #

# C-1.19 Demonstrate how to use Python's list comprehension syntax to produce
# the list [ a , b , c , ..., z ], but without having to type all 26 such
# characters literally.

	# print [chr(n) for n in range(97,123)]

# *************************************************** #

# C-1.20 Python's random module includes a function shuffle(data) that accepts a
# list of elements and randomly reorders the elements so that each possible
# order occurs with equal probability. The random module includes a
# more basic function randint(a, b) that returns a uniformly random integer
# from a to b (including both endpoints). Using only the randint function,
# implement your own version of the shuffle function.

	# loop over list
	# find min and max
	# use min,max as randint(a,b) arguments
	# loop over randInt until it produces the shuffle


def custom_shuffle(sequence):
	
	sequence_dict = {}
	ret_val = []	
	for num in sequence:
		if num not in sequence_dict:
			sequence_dict[num] = {}
			sequence_dict[num]['randomized'] = 0 
			sequence_dict[num]['occurences'] = 1
		else:
			sequence_dict[num]['occurences'] += 1

	curr_min = None
	curr_max = 0
	for num in sequence:
		curr_min = num if curr_min == None else curr_min
		curr_max = num if num > curr_max else curr_max
		curr_min = num if num < curr_min else curr_min

	all_done = False

	import random
	while not all_done:
		curr_num = random.randint(curr_min,curr_max)
		if (curr_num not in sequence_dict) or sequence_dict[curr_num]['randomized'] < sequence_dict[curr_num]['occurences']:
			ret_val.append(curr_num)
			sequence_dict[curr_num]['randomized'] += 1

		sub_done = True
		for num in sequence_dict:
			if sequence_dict[num]['occurences'] > sequence_dict[num]['randomized']:
				sub_done = False
				break

		all_done = sub_done

	return ret_val

# print custom_shuffle([1,2,3,4,5,6,7,8,8])

# *************************************************** #

# C-1.21 Write a Python program that repeatedly reads lines from standard input
# until an EOFError is raised, and then outputs those lines in reverse order
# (a user can indicate end of input by typing ctrl-D).


def read_lines():
	input_store = []
	while True:
	    try:
	    	data = raw_input("Tell me something: ")
	    	input_store.append(data)
	    except EOFError:
	        break
	input_store.reverse()
	# print input_store

# *************************************************** #

# C-1.22 
# Write a short Python program that takes two arrays a and b of length n
# storing int values, 
# and returns the dot product of a and b.
#  That is, it returns
# an array c of length n such that c[i] = a[i] * b[i], for i = 0,.....,n-1.

def dot_product(a,b):
	ret_val = []
	for index, number in enumerate(a):
		ret_val.append(number * b[index])
	return ret_val

# print dot_product([1,2,3,4,5,6,7,8,9], [9,8,7,6,5,4,3,2,1])

# *************************************************** #

# C-1.24 Write a short Python function that counts the number of vowels in a given
# character string.

def vowel_count(sentence):
	ret_val = 0
	for char in sentence:
		if char in ['a','e','i','o','u']:
			ret_val +=1
	return ret_val

# print vowel_count('This is my very original sentence to test this function')


# *************************************************** #

# C-1.25 Write a short Python function that takes a string s, representing a sentence,
# and returns a copy of the string with all punctuation removed. For example,
# if given the string "Let s try, Mike.", this function would return
# "Lets try Mike".

def remove_punctuation(string):
	return string.translate(None, "',.;")

# print remove_punctuation("This is user's sentence, with some punctuation.")

# *************************************************** #

# C-1.26 Write a short program that takes as input three integers, a, b, and c, from
# the console and determines if they can be used in a correct arithmetic
# formula (in the given order), like "a+b = c," "a = b-c," or "a * b = c."

def determine_arithmetic(a,b,c):
	return {
		str(a) + ' + ' + str(b) + ' = ' + str(c) : (a + b) == c,
		str(a) + ' = ' + str(b) + ' - ' + str(c) : a == (b - c),
		str(a) + ' * ' + str(b) + ' = ' + str(c) : (a * b) == c
	}

# print determine_arithmetic(1,3,4)

# *************************************************** #

# C-1.27 In Section 1.8, we provided three different implementations of a generator
# that computes factors of a given integer. The third of those implementations,
# from page 41, was the most efficient, but we noted that it did not
# yield the factors in increasing order. Modify the generator so that it reports
# factors in increasing order, while maintaining its general performance advantages.

# Original
def factors(n):
	k = 1
	while k * k < n:
		print "-------- " + str(k)
		if n % k == 0:
			print "Yielding k : " + str(k)
			yield k
			print "Yielding n//k : " + str(n // k)
			yield n // k
		k += 1
	if k * k == n:
		print "Yielding k : " + str(k)
		yield k


# Original
def factors_altered(n):
	k = 1
	while k * k < n:
		print "-------- " + str(k)
		if n % k == 0:
			print "Yielding k : " + str(k)
			yield k


			print "Yielding n//k : " + str(n // k)
			yield n // k
		k += 1
	if k * k == n:
		print "Yielding k : " + str(k)
		yield k


for n in factors_altered(100):
	print ''
print 10//2
# *************************************************** #

# C-1.28 The p-norm of a vector v = (v1,v2,...,vn) in n-dimensional space is defined
# as ||v|| = p√(v(1..p) +v(2..p) + ··· + v(n..p))
# For the special case of p = 2, this results in the traditional Euclidean
# norm, which represents the length of the vector. For example, the Euclidean
# norm of a two-dimensional vector with coordinates (4,3) has a
# Euclidean norm of √(42 + 32) = √(16+9) = √(25) = 5. Give an implementation
# of a function named norm such that norm(v, p) returns the p-norm
# value of v and norm(v) returns the Euclidean norm of v. You may assume
# that v is a list of numbers.


# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #