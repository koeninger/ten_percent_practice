def make_averager():
    count = 0
    total = 0

    def averager():
        nonlocal count, total
        count += 1
        total += new_value
        return total / count

    return averager