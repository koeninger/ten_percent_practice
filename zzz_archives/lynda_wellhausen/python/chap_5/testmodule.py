def iterquad ():
    for i in range(5):
        yield (i*i)

def quadcube (x):
    return x**2, x**3

def makelist():
    a = []
    for i in range(1,20):
        a.append(i)
        print "appending", i, ":", a
    return a
makelist()

