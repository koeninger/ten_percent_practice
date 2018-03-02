println("Hello")
val b: Byte = 10
val s: Short = b
val d: Double = s

val l: Long = 20
//val i: Int = l
val i: Int = l.toInt

val anInt = 5
val yellowRgb = 0xffff00
val id = 1001
val pi = 3.1416

val hello = "Hello World"
val signature = "Cheers, \nChris"

val greeting = "Hello, " + "World"
val matched = (greeting == "Hello, World")

val theme = "Na " * 16 + "Batman!"
//WWwwHhhhHHHhahahahahahaaaaa

val greeting = """formmating a file for multiple 
| lines. that run across many rows
| in cases where this might look better."""

val approx = 355/113f
println("Pi, using 355/113, is about " + approx + ".")
println(s"Pi, using 355/113, is about $approx.")

val item = "apple"
s"How do you like them ${item}s?"
s"Fish n chips n vinegar, ${"pepper "*3}salt"

f"I wrote a new $item%.3s today"
f"Enjoying this $item ${355/113.0}%.5f times today"

val input = "Enjoying this apple 3.14159 times today"
val pattern = """.* apple ([\d.]+) times .*""".r

val pattern(amountText) = input
val amount = amountText.toDouble

val c = 'A'
val i: Int = c
val t: Char = 116

val isFalse = !true
val isTrue = !isFalse
val unequal = (5 != 6)
val isLess = (5 < 6)

val unequalAndLess = unequal & isLess
val definitelyFalse = false && unequal

val zero = 0
val isValid = zero > 0

val nada = ()
