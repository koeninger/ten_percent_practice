let sum n = if n < 1 then 0 else n + sum (n - 1)
in sum 1000 end
