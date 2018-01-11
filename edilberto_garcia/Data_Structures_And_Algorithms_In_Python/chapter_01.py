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


