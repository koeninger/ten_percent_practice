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
    Return True if charge was processed; False if charge was denied.
    """
    if not isinstance(price, (int, float)): # Answer here; check type
        raise TypeError('Price must be numeric') #Answer here; raise error if not numerical
    if price + self._balance > self._limit:  # if charge would exceed limit,
        return False                           # cannot accept charge
    else:
        self._balance += price
    return True

def make_payment(self, amount):
    if not isinstance(amount, (int, float)): # Answer here; check type
        raise TypeError('Amount must be numeric') #Answer here; raise error if not numerical
    """Process customer payment that reduces balance."""
    self._balance -= amount


# *************************************************** #

# R-2.6 If the parameter to the make_payment method of the CreditCard class
# were a negative number, that would have the effect of raising the balance
# on the account. Revise the implementation so that it raises a ValueError if
# a negative value is sent.


def make_payment(self, amount):
    if not isinstance(amount, (int, float)): # Answer here; check type
        raise TypeError('Amount must be numeric') #Answer here; raise error if not numerical
    if amount < 0:
        raise ValueError('Cannot make payments with negative values')
    """Process customer payment that reduces balance."""
    self._balance -= amount

# *************************************************** #

# R-2.7 The CreditCard class of Section 2.3 initializes the balance of a new account
# to zero. Modify that class so that a new account can be given a
# nonzero balance using an optional fifth parameter to the constructor. The
# four-parameter constructor syntax should continue to produce an account
# with zero balance.


def __init__(self, customer, bank, acnt, limit, balance = 0):
    """Create a new credit card instance.
    The initial balance is zero.
    customer  the name of the customer (e.g., 'John Bowman')
    bank      the name of the bank (e.g., 'California Savings')
    acnt      the acount identifier (e.g., '5391 0375 9387 5309')
    limit     credit limit (measured in dollars)
    """
    self._customer = customer
    self._bank = bank
    self._account = acnt
    self._limit = limit
    self._balance = balance

# *************************************************** #

# R-2.8 Modify the declaration of the first for loop in the CreditCard tests, from
# Code Fragment 2.3, so that it will eventually cause exactly one of the three
# credit cards to go over its credit limit. Which credit card is it?

if __name__ == __main__ :
    wallet = []
    wallet.append(CreditCard( John Bowman , California Savings ,
    5391 0375 9387 5309 , 2500) )
    wallet.append(CreditCard( John Bowman , California Federal ,
    3485 0399 3395 1954 , 3500) )
    wallet.append(CreditCard( John Bowman , California Finance ,
    5391 0375 9387 5309 , 5000) )

    for val in range(1, 17):
        wallet[0].charge(val)
        wallet[1].charge(2 val)
        wallet[2].charge(3 val)

    for c in range(3):
        print( Customer = , wallet[c].get customer( ))
        print( Bank = , wallet[c].get bank())
        print( Account = , wallet[c].get account( ))
        print( Limit = , wallet[c].get limit( ))
        print( Balance = , wallet[c].get balance())
        while wallet[c].get balance( ) > 100:
        wallet[c].make payment(100)
        print( New balance = , wallet[c].get balance())
        print( )


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
