val m = Map("AAPL" -> 597, "MSFT" -> 40)
val n = m - "AAPL" + ("GOOG" -> 521)
println(m)

val nums = collection.mutable.Buffer(1)
for (i <- 2 to 10) nums += i
println(nums)
val nums = collection.mutable.Buffer[Int]()
for (i <- 1 to 10) nums += i 
println(nums)
val l = nums.toList

val m =Map("AAPL" -> 597, "MSFT" -> 40)
val b = m.toBuffer
b trimStart 1
b += ("GOOG" -> 521)
val n = b.toMap
b += ("GOOG" -> 521)
val l = b.toList
val s = b.toSet

val b= Set.newBuilder[Char]
b += 'h'
b ++= List('e', 'l', 'l', 'o')
val helloSet = b.result

val colors = Array("red", "green", "blue")
colors(0) = "purple"

//println("Very purple: " + colors)
val files = new java.io.File(".").listFiles
val scala = files map (_.getName) filter(_ endsWith "scala")

val inks = Seq('C', 'M', 'Y', 'K')

val hi = "Hello, " ++ "worldy" take 12 replaceAll ( "w","W")

def inc(i: Int): Stream[Int] = Stream.cons(i, inc(i+1))
val s = inc(1)
val l = s.take(5).toList

def inc(head: Int): Stream[Int] = head #:: inc(head+1)
inc(10).take(10).toList

def to(head: Char, end:Char): Stream[Char] = (head > end) match {
  case true => Stream.empty
  case false => head #:: to((head+1).toChar, end)
}

val hexChars = to('A', 'F').take(20).toList

var x: String = "Indeed"
var a = Option(x)
x = null
var b = Option(x)
println(s"a is defined? ${a.isDefined}")
println(s"b is not defined? ${b.isEmpty}")
def divide(amt: Double, divisor: Double): Option[Double] = {
  if (divisor == 0) None
  else Option(amt / divisor)
}

val legit = divide(5, 2)
val illegit = divide(3, 0)

val odds = List(1, 3, 5)
val firstOdd = odds.headOption
val evens = odds filter (_ % 2 == 0)
val firstEven = evens.headOption

val words = List("risible", "scavenger", "gist")
val upperase = words find (w => w == w.toUpperCase)
val lowercase = words find (w => w == w.toLowerCase)

val filtered = lowercase filter (_ endsWith "ible") map (_.toUpperCase)
val exactSize = filtered filter (_.size > 15) map (_.size)
