val t1: (Int, Char) = (1, 'a')
val t2: (Int, Char) = Tuple2[Int, Char](1, 'a')
val f1: Int=>Int = _ + 2
val f2: Int=>Int = new Function1[Int, Int] { def apply(x: Int) = x * 2 }
