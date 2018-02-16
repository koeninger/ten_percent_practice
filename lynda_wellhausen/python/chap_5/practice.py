def divisors():
    inpt = int(input("Enter top of range"))
    x = range(1, inpt)
    for elem in x:
        print elem

# >>> from practice import divisors
# >>> divisors()
# Enter top of range4
# 1
# 2
# 3
# >>> 11
# 11
# >>> divisors()
# Enter top of range11
# 1
# 2
# 3
# 4
# 5
# 6
# 7
# 8
# 9
# 10
# >>>

# debugging tools

>>> mystring = "testing 123"
>>> repr(mystring)
"'testing 123'"
>>> type(mystring)
<type 'str'>
>>> dir()
['__builtins__', '__doc__', '__name__', '__package__', 'mystring']
>>>

# example of a type error - no error msg. 

>>> repr(mystring)
"'testing 123'"
>>> type(mystring)
<type 'str'>
>>> dir()
['__builtins__', '__doc__', '__name__', '__package__', 'mystring']
>>> price = raw_input('enter price: ')
enter price: 10.99
>>> price * 3
'10.9910.9910.99'

# example of entering wrong type (string instead of float)
>>> price = float(raw_input('enter price: '))
enter price: Testing
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ValueError: could not convert string to float: Testing
>>>

# use python -m pdb x.py to load and debug a module. 
# python -m pdb testmodule.py outs the following: 
# s to step through, p <name of value> to see a 

> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(10)makelist()
-> for i in range(1,20):
(Pdb) s
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(11)makelist()
-> a.append(i)
(Pdb) s
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(12)makelist()
-> print "appending", i, ":", a
(Pdb) s
appending 18 : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]

# p <name of value> to see a value at a particular Step ex: 
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(12)makelist()
-> print "appending", i, ":", a
(Pdb) p a
[1, 2, 3, 4, 5, 6]
