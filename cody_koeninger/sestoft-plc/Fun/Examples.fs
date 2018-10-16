module Examples

open Parse
open ParseAndRun

let e4_2_2 = fromString """
let pow3 n = if n < 1 then 1 else 3 * pow3 (n - 1)
in pow3 8 end
"""

let e4_2_3 = fromString """
let pow3 n = if n < 1 then 1 else 3 * pow3 (n - 1)
  in let sumPow3 x = if x < 1 then 0 else pow3 x + sumPow3 (x - 1)
    in sumPow3 11
    end
  end
"""

let e4_2_3_5 = fromString """
let f x =
  let g y = if y < 1 then 1 else x * g (y - 1)
    in g 8
    end
  in f 2
  end
"""

let e4_2_4 = fromString """
let f x =
  let g y = if y < 1 then 1 else x * g (y - 1)
    in g 8
    end
  in let h z = if z < 1 then 0 else (f z) + (h (z - 1))
    in h 10
    end
  end
"""

let e4_4_1 = fromString """
let pow x n = if n=0 then 1 else x * pow x (n-1)
  in pow 3 8
  end
"""

let e4_4_2 = fromString """
let max2 a b = if a<b then b else a
  in let max3 a b c = max2 a (max2 b c)
    in max3 25 6 62
    end
  end
"""

let e4_5 = fromString """
let x = 3
  in if (0 < x) && (x < 3) || (x + 1 = 4) then 23 else 42
  end
"""

let e4_6 = fromString """
let max xy = if #1(xy) > #2(xy) then #1(xy) else #2(xy)
in max (3, 88) end
"""
