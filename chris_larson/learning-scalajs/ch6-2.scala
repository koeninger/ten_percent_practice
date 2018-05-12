List(0, 1, 0) collect {case 1 => "ok"}
List("milk,tea") flatMap (_.split(','))
List("milk", "tea") map (_.toUpperCase)

List(41, 59, 26).max
List(10.9, 32.5, 4.23, 5.67).min
List(5, 6, 7).product
List(11.3, 23.5, 7.2).sum

List(34, 29, 18) contains 29
List(0, 4, 3) endsWith List(4, 3)
List(24, 17, 32) exists (_ < 18)
List(24, 17, 32) forall (_ < 18)
List(0, 4, 3) startsWith List(0)

val validations = List(true, true, false, true, true, true)
val valid1 = !(validations contains false)
val valid2 = validations forall (_ == true)
val valid3 = validations.exists(_ == false) == false

def contains(x: Int, l: List[Int]): Boolean = {
  var a: Boolean = false
  for (i <- l) { if (!a) a = (i ==x) }
  a
}
val included = contains(19, List(46, 19, 92))

def boolReduce(l: List[Int], start: Boolean)(f: (Boolean, Int) => Boolean): Boolean = {
  var a = start
  for (i <- l) a = f(a, i)
  a
}
val included = boolReduce(List(46, 19, 92), false) { (a, i) => if (a) a else (i == 19)}

def reduceOp[A, B](l: List[A], start: B)(f: (B, A) => B): B = {
  var a = start
  for (i <- l) a = f(a, i)
  a
}
val included = reduceOp(List(46, 19, 92), false) { (a, i) => if (a) a else (i == 19)
}
val answer = reduceOp(List(11.3, 23.5, 7.2), 0.0)(_ + _)
