# R-2.1 Give three examples of life-critical software applications.

	# - Medical
	# - Automotive 
	# - Avionics

# R-2.2 Give an example of a software application in which adaptability can mean
# the difference between a prolonged lifetime of sales and bankruptcy.

	# Any organization involved with developing software for mobile devices, 
	# they need to adapt their software over the various generations of growing mobile tech

# *************************************************** #

# R-2.3 Describe a component from a text-editor GUI and the methods that it encapsulates.
	#
	# The file 
	# Methods: read(), write(), getText(), delete()
	# 
	#

# *************************************************** #

# R-2.4 Write a Python class, Flower, that has three instance variables of type str,
# int, and float, that respectively represent the name of the flower, its number
# of petals, and its price. Your class must include a constructor method
# that initializes each variable to an appropriate value, and your class should
# include methods for setting the value of each type, and retrieving the value
# of each type.

class Flower:

	def __init__(self, name, petal_count, price):
		self._name = name
		self._petal_count = petal_count
		self._price = price
	
	def set_name(self, name):
		self._name = name

	def set_petal_count(self, petal_count):
		self._petal_count = petal_count

	def set_price(self, price):
			self._price = price

	def get_name(self):
		return self._name

	def get_petal_count(self):
			return self._petal_count

	def get_price(self):
			return self._price

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
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
# *************************************************** #
