# R-1.1 Write a short Python function, is multiple(n, m), that takes two integer
# values and returns True if n is a multiple of m, that is, n = mi for some
# integer i, and False otherwise.
def is_multiple(n,m):
	return n % m == 0
# print is_multiple(10,2)

# *************************************************** #

# R-1.2 Write a short Python function, is_even(k), that takes an integer value and
# returns True if k is even, and False otherwise. However, your function
# cannot use the multiplication, modulo, or division operators.
def is_even(k):
	k = str(k)
	return int(k[-1]) in [0,2,4,6,8]

# *************************************************** #


# R-1.3 Write a short Python function, minmax(data), that takes a sequence of
# one or more numbers, and returns the smallest and largest numbers, in the
# form of a tuple of length two. Do not use the built-in functions min or
# max in implementing your solution.
def minmax(data):
	curr_min = None
	curr_max = 0
	for num in data:
		curr_min = num if curr_min == None else curr_min
		curr_max = num if num > curr_max else curr_max
		curr_min = num if num < curr_min else curr_min
	return (curr_min, curr_max)
# print minmax([2,3,10,4,6,99,3])

# *************************************************** #

# R-1.4 Write a short Python function that takes a positive integer n and returns
# the sum of the squares of all the positive integers smaller than n
def sum_squares(n):
	ret_val = 0;
	for i in range(1, n):
		ret_val += (i * i)
	return ret_val
# print sum_squares(12)

# *************************************************** #

# R-1.5 Give a single command that computes the sum from Exercise R-1.4, relying
# on Python's comprehension syntax and the built-in sum function.

# sum([n * n for n in range(1, 12)])

# *************************************************** #

# R-1.6 Write a short Python function that takes a positive integer n and returns
# the sum of the squares of all the odd positive integers smaller than n.

def sum_squares_odd(n):
	ret_val = 0;
	for i in range(1, n):
		if i % 2 == 1:
			ret_val += i * i
	return ret_val
# print sum_squares_odd(12)

# *************************************************** #

# R-1.7 Give a single command that computes the sum from Exercise R-1.6, relying
# on Python's comprehension syntax and the built-in sum function.

# sum([n * n for n in range(1, 12) if n % 2 == 1])

# R-1.8 Python allows negative integers to be used as indices into a sequence,
# such as a string. If string s has length n, and expression s[k] is used for index
# -n <= k < 0, what is the equivalent index j >= 0 such that s[j] references
# the same element?

	#My Ans: k + n = j
	# s = "My string", n = 9
	# s[3] = 's',  s[-9] = 's'
	# -9(k) + 9(n) = 3(j) 

# *************************************************** #

# R-1.9 What parameters should be sent to the range constructor, to produce a
# range with values 50, 60, 70, 80?

# print range(50, 81, 10)

# *************************************************** #

# R-1.10 What parameters should be sent to the range constructor, to produce a
# range with values 8, 6, 4, 2, 0, -2, -4, -6, -8?

# print range(8, -9, -2)

# *************************************************** #

# R-1.11 Demonstrate how to use Python's list comprehension syntax to produce
# the list [1, 2, 4, 8, 16, 32, 64, 128, 256].

# print [2**k for k in range(0, 9)]

# *************************************************** #

# R-1.12 Python's random module includes a function choice(data) that returns a
# random element from a non-empty sequence. The random module includes
# a more basic function randrange, with parameterization similar to
# the built-in range function, that return a random choice from the given
# range. Using only the randrange function, implement your own version
# of the choice function.


def custom_choice(sequence):
	import random
	print 'sequence'
	print sequence
	curr_min = None
	curr_max = 0
	for num in sequence:
		curr_min = num if curr_min == None else curr_min
		curr_max = num if num > curr_max else curr_max
		curr_min = num if num < curr_min else curr_min

	while True:
		number = random.randrange(curr_min, curr_max + 1)
		if number in sequence:
			return number

# print custom_choice([1,2,3,4,5,-6,7,8,9, 100, 2, -2, -4, 5, 1000])



