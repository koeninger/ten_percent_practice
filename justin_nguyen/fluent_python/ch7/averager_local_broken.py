def make_averager():
    count = 0
    total = 0

    def averager(new_value):
        # this is broken because += assigns, so it looks like
        # count = count + 1
        # meaning count is creating a new variable and is no longer a free variable (no longer saved in closure)
        count += 1
        total += new_value
        return total / count

    return averager