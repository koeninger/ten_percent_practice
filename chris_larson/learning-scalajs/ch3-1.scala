"hello"
"hel" + "l" + "o"
val x = 5 * 20; val amount = x + 10
val amount = { val x = 5 * 20; x + 10 }
val amount = { 
  val x = 5 * 20
  x + 10 
}
if ( 47 % 3 > 0 ) println("not a multiple of 3")
val x = 10; val y = 20
val max = if( x > y ) x else y
val max = x > y match {
  case true => x
  case false => y
}

val status = 500
val message = status match {
  case 200 => "ok"
  case 400 => println("Error - your side"); "error"
  case 500 => println("Error - our side"); "error"
}

val day = "MON"
val kind = day match {
  case "MON" | "TUE" | "WED" | "THU" | "FRI" => "weekday"
  case "SAT" | "SUN" => "weekend"
}

val thing = "thing"
val result = thing match {
  case "something" => "here"
  case _ => "not here"
}

val resultEcho = thing match {
  case "something" => "here"
  case other => "not here " + other
}

val message = "Ok"
val status = message match {
  case "Ok" => 200
  case other => {
    println(s"Couldn't parse $other")
    -1
  }
}

val status = message match {
  case "Authorized" => 200
  case _ => {
    println(s"Couldn't parse $message")
    -1
  }
}

val response: String = null
response match {
  case s if s != null => println(s"Received '$s'")
  case s => println("Error! Received a null response")
}

val x: Int = 111
val y: Any = x

y match {
  case x: String => s"'x'"
  case x: Double => f"$x%.2f"
  case x: Float => f"$x%.2f"
  case x: Long => s"${x}l"
  case x: Int => s"${x}i"
}

for (x <- 1 to 7) { println(s"Day $x:")}
for (x <- 1 to 7) yield { s"Day $x:"}

val thress = for (i <- 1 to 20 if i % 3==0) yield i
for { x <- 1 to 2
y <- 1 to 3 }
{println(s"($x,$y)")}

val powersOf2 = for (i <- 0 to 8; pow = 1 << i) yield pow
