def make_averager():
    series = []

    def averager(new_value):
        series.append(new_value)
        # series (in averager) is a free variable (not bound to local scope)
        total = sum(series)
        return total/len(series)

    return averager