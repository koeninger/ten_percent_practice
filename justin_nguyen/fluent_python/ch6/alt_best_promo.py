
#problem: we have to add new promos to list of promos.

#some possible solutions
promos = [globals()[name] for name in globals()
    if name.endswith('_promo')
    and name != 'best_promo']

promos = [func for name, func in
    inspect.getmembers(promotions, insepct.isfunction)]