# string practice

>>> path = "C:\\Applications"
>>> print path
C:\Applications

>>> path = r"C:\Applications"
>>> path
'C:\\Applications'
>>> print path
C:\Applications

>> cheese="cheese available:\nblue\nchedder\nboursin"
>>> cheese
'cheese available:\x08lue\\chedder\x08oursin'

>>> print cheese
cheese available:
blue
chedder
boursin


>>> a="a"
>>> b="b"
>>> a + b
'ab'
>>> c="c"*3
>>> c
'ccc'
>>> "5" *6
'555555'
>>> int(5)*6
30
>>> m = "mississippi"
>>> m.count('s')
4
>>> string = "the quick brown fox"
>>> 'goose' in string
False
>>> 'quick' in string
True
>>> string.endswith('fox')
True
>>> str('2345')
'2345'
>>> x="TESTING"
>>> x.lower()
'testing'
>>> stirng = "truly, madly, deeply"
>>> string[2]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'string' is not defined
>>> stirng[2]
'u'
>>>
>>> string = "truly, madly, deeply"
>>> string[7:12]
'madly'
>>> string = "truly, madly, deeply"
>>> string[7:12]
'madly'
#example of using a step
>>> string="123456789"
>>> string[0:9:2]
'13579'

>>> alpha ='abcde'
>>> alpha[0]
'a'
>>> alpha[0:3]
'abc'
>>> alpha[:2]
'ab'
>>> alpha[3:10]
'de'
>>> alpha[10]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
IndexError: string index out of range
>>> alpha[3:2]
''
>>> alpha[-1]
'e'
>>> alpha[-3:-1]
'cd'
>>> alpha[-3]
'c'
>>> alpha[:]
'abcde'
>>> alpha[::-1]
'edcba'
>>> candy = "dark chocolate bars"
>>> morecandy = "milk" +candy[4:]
>>> morecandy
'milk chocolate bars'
>>>

