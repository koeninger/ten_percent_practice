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
