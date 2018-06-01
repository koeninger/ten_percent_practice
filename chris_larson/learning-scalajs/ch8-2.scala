class Car(val make: String, var reserved: Boolean) {
  def reserve(r: Boolean): Unit = { reserved = r }
}

val t = new Car("Toyota", false)
t.reserve(true)
println(s"My ${t.make} is now reserved? ${t.reserved}")

val t2 = new Car(reserved = false, make = "Tesla")
println(t2.make)

class Lotus(val color: String, reserved: Boolean) extends Car("Lotus", reserved)
val l = new Lotus("Silver", false)
println(s"Rquest a ${l.color} ${l.make}")
