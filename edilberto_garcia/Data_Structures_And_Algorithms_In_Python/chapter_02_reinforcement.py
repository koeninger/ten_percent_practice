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

# R-2.5 Use the techniques of Section 1.7 to revise the 'charge' and 'make_payment'
# methods of the CreditCard class to ensure that the caller sends a number
# as a parameter.



 def charge(self, price):
 """Charge given price to the card, assuming sufficient credit limit.

 Return True if charge was processed.
 Return False and assess 5 fee if charge is denied.
 """
 success = super().charge(price) # call inherited method
 if not success:
 self. balance += 5 # assess penalty
 return success # caller expects return value




# *************************************************** #

# R-2.6 If the parameter to the make payment method of the CreditCard class
# were a negative number, that would have the effect of raising the balance
# on the account. Revise the implementation so that it raises a ValueError if
# a negative value is sent.




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
