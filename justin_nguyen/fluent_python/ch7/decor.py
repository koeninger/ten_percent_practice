

@decorate
def target():
    print('running target()')



""" code above is same as code below"""


def target():
    print('running target()')

target = decorate(target)



""" """



def deco(func):
    def inner():
        print('running inner()')
    return inner