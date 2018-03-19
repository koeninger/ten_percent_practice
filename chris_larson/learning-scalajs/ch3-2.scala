var x = 10; while (x > 0) x -= 1
do println(s"Here I am, x = $x") while (x > 0)

val name: String = null
val matched = name match {
  case s if s != null => println(s"$name")
  case _ => println(s"n/a")
}

val amount: Double = -1
val result = amount match {
  case s if s > 0 => println("greater")
  case s if s == 0 => println("same")
  case s if s < 0 => println("less")
  case _ => println("error")
}

val color: String = "yellow"

val colorCode = color match {
  case "cyan" => "0x110000"
  case "magenta" => "0x001100"
  case "yellow" => "0x000011"
  case _ => "error"
}

val counting = for (i <- 1 to 100) {
  print(s"$i")
  if (i % 5==0) println("\n") else print(", ")
}

val counting = for (i <- 1 to 100) {
  print(s"$i: ")
  if (i % 5==0) print("type")
  if (i % 3==0) print("safe")
  print("\n")
}

for (i <- 1 to 100) { print(s"$i: "); if (i % 5==0) print("type"); if (i % 3==0) print("safe"); print("\n")}