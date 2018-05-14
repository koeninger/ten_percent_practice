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

val alist = List(4, 5, 6)
alist.fold(0)(_ + _)
alist.foldLeft(0)(_ + _)
alist.foldRight(0)(_ + _)
alist.reduce(_ + _)
alist.reduceLeft(_ + _)
alist.reduceRight(_ + _)
alist.scan(0)(_ + _)
alist.scanLeft(0)(_ + _)
alist.scanRight(0)(_ + _)
val included = List(46, 19, 92).foldLeft(false) { (a, i) => if (a) a else (i == 19)}
val answer = List(11.3, 23.5, 7.2).reduceLeft(_ + _)

List(24, 99, 104).mkString(", ")
List('f', 't').toBuffer
Map("a" -> 1, "b" -> 2).toList
Set(1 -> true, 3 -> true).toMap
List(2, 5, 5, 3, 2).toSet
List(2, 5, 5, 3, 2).toString

import collection.JavaConverters._
List(12, 29).asJava
new java.util.ArrayList(5).asScala

val statuses = List(500, 404)
val msg = statuses.head match {
  case x if x < 500 => "okay"
  case _ => "whoah, an error"
}

val msg = statuses match {
  case x if x contains(500) => "has error"
  case _ => "okay"
}

val msg = statuses match {
  case List(404, 500) => "not found & error"
  case List(500, 404) => "error & not found"
  case List(200, 200) => "okay"
  case _ => "not sure what happened"
}

val msg = statuses match {
  case List(500, x) => s"Error followed by $x"
  case List(e, x) => s"$e was followed by $x"
}

val head = List('r', 'g', 'b') match {
  case x :: xs => x
  case Nil => ' '
}

val code = ('h', 204, true) match {
  case (_, _, false) => 501
  case ('c', _, true) => 302
  case ('h', x, true) => x
  case (c, x, true) => {
    println(s"Did not expect code $c")
    x
  }
}