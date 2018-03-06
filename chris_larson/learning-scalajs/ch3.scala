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
