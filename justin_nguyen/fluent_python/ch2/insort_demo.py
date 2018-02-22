import bisect
import random

SIZE = 7
random.seed(1729)

num_list = []
for i in range(SIZE):
    new_item = random.randrange(SIZE*2)
    bisect.insort(num_list, new_item)
    print('%2d -> ' % new_item, num_list)
