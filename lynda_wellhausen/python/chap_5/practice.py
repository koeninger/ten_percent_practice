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
# python -m pdb testmodule.py outputs the following: 
# s to step through, p <name of value> to see a (from testmodule.py)

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

# Further practice with debugging with PDB from the command line
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(11)makelist()
-> a.append(i)
(Pdb) s
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(12)makelist()
-> print "appending", i, ":", a
(Pdb) p a
[1, 2, 3, 4]
(Pdb) n
appending 4 : [1, 2, 3, 4]
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(10)makelist()
-> for i in range(1,20):
(Pdb) n
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(11)makelist()
-> a.append(i)
(Pdb)
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(12)makelist()
-> print "appending", i, ":", a
(Pdb) n
appending 5 : [1, 2, 3, 4, 5]
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(10)makelist()
-> for i in range(1,20):
(Pdb) l
  5     def quadcube (x):
  6         return x**2, x**3
  7
  8     def makelist():
  9         a = []
 10  ->     for i in range(1,20):
 11             a.append(i)
 12             print "appending", i, ":", a
 13         return a
 14     makelist()
 15
(Pdb) c
appending 6 : [1, 2, 3, 4, 5, 6]
appending 7 : [1, 2, 3, 4, 5, 6, 7]
appending 8 : [1, 2, 3, 4, 5, 6, 7, 8]
appending 9 : [1, 2, 3, 4, 5, 6, 7, 8, 9]
appending 10 : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
appending 11 : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
appending 12 : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
appending 13 : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
appending 14 : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
appending 15 : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
appending 16 : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
appending 17 : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17]
appending 18 : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
appending 19 : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19]
The program finished and will be restarted
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(1)<module>()
-> def iterquad ():
(Pdb) a
(Pdb) s
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(5)<module>()
-> def quadcube (x):
(Pdb) s
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(8)<module>()
-> def makelist():
(Pdb) s
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(14)<module>()
-> makelist()
(Pdb) s
--Call--
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(8)makelist()
-> def makelist():
(Pdb) s
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(9)makelist()
-> a = []
(Pdb) a
(Pdb) a
(Pdb) s
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(10)makelist()
-> for i in range(1,20):
(Pdb) a
(Pdb) b 11
Breakpoint 1 at /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py:11
(Pdb) c
> /Users/wellhausen/Documents/ten_percent_practice/lynda_wellhausen/python/chap_5/testmodule.py(11)makelist()
-> a.append(i)
(Pdb) p a
[]
(Pdb)

