val numbers = List(32, 95, 24, 21, 17)
val colors = List("red", "green", "blue")
println(s"I have ${colors.size} colors: $colors")
colors.head
colors.tail
colors(1)
colors(2)

var total = 0; for (i <- numbers) {total += i }
for (c <- colors) { println(c) }

colors.foreach( (c: String) => c.size )
val sizes = colors.map( (c: String) => c.size )

val total = numbers.reduce( (a: Int, b: Int) => a + b )

val unique = Set(10, 20, 30, 20, 20, 10)
val sum = unique.reduce( (a: Int, b: Int) => a + b )

val colorMap = Map("red" -> 0xFF0000, "green" -> 0xFF00, "blue" -> 0xFF)
val redRGB = colorMap("red")
val cyanRGB = colorMap("green") | colorMap("blue")
val hasWhite = colorMap.contains("white")
for (pairs <- colorMap) { println(pairs) }

val colors = List("red", "green", "blue")
val oddsAndEvens = List(List(1,3,5),List(2,4,6))
val keyValues = List(('A', 65), ('B', 66), ('C', 67))

val primes = List(2, 3, 5, 7, 11, 13)
val first = primes(0)
val fourth = primes(3)
val first = primes.head
val remaining = primes.tail

var i = primes
while( ! i.isEmpty) { print(i.head + ", "); i = i.tail }

def visit(i: List[Int]) { if (i.size > 0) {print(i.head + ", ");
  visit(i.tail)
}}
visit(primes)

var primes = List(2, 3, 5, 7, 11, 13)
var i = primes
while(i != Nil) { print(i.head + ", "); i=i.tail}
val l: List[Int] = List()
l == Nil
val m: List[String] = List("a")
m.head
m.tail == Nil

val numbers = 1 :: 2 :: 3 :: Nil
val first = Nil.::(1)
first.tail == Nil

val second = 2 :: first
second.tail == first

val f = List(23, 8, 14, 21) filter (_ > 18)
val p = List(1, 2, 3, 4, 5) partition (_ < 3)
val s = List("apple", "to") sortBy (_.size)

val appended = List(1, 2, 3, 4) :+ 5
val suffix = appended takeRight 3
val middle = suffix dropRight 2
