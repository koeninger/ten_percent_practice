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
