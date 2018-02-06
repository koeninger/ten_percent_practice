print 'testing how scripts an interactive mode communicate'

x = 500

print "the value of x is:", x

def tinyfunction(x):
    print "testing how modules and interactive mode communicate"
    print "you passed me the parameter", x
    z = x**2
    print x, "squared is", z
    return z


