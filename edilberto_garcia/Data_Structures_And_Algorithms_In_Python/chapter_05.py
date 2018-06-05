# P-5.33:  Write a Python program for a matrix class that can add and multiply two-dimensional arrays of numbers,
 # assuming the dimensions agree appropriately for the operation.

class Matrix:
	matrix = []

	def add(self, other):
		result = []
		for index,val in enumerate(self.matrix):
			row = []
			for subindex, j in enumerate(val):
				row.append(j + other.matrix[index][subindex])
				result.append(row)
		return result 
	


	def multiply(self, other):
		product = [0] * len(self.matrix)
		# for index,val in enumerate(self.matrix):
		for i in range(len(self.matrix)):
			product[i] = [0] * len(self.matrix[i])
			print 'i:', i
			for j in range(len(other.matrix[0])):
				print 'j:', j
				for k in range(len(self.matrix[0])):
					print 'k:', k
					product[i][j] += self.matrix[i][k] * other.matrix[k][j]
		return product


matrix_a = Matrix()
matrix_a.matrix = [
	[12,15,7,4],
	[14,6,20,8],
	[2,17,16,11],
	[9,18,5,13]
]

matrix_b = Matrix()
matrix_b.matrix = [
	[19,12,1,9],
	[17,15,3,18],
	[7,10,20,2],
	[11,14,4,8]
]


# print matrix_a.add(matrix_b)



print matrix_a.multiply(matrix_b)

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