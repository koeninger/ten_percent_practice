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

class Car(val make: String, var reserved: Boolean = true, val year: Int = 2018) {
  override def toString = s"$year $make, reserved = $reserved"
}
val a = new Car("Acura")
val l = new Car("Lexus", year = 2010)
val p = new Car(reserved = false, make = "Porsche")

class Singular[A](element: A) extends Traversable[A] {
  def foreach[B](f: A => B) = f(element)
}
val p = new Singular("Planes")
p foreach println

abstract class Car {
  val year: Int
  val automatic: Boolean = true
  def color: String
}
new Car()

class RedMini(val year: Int) extends Car {
  def color = "Red"
}

val m: Car = new RedMini(2005)

class Mini(val year: Int, val color: String) extends Car
val redMini: Car = new Mini(2005, "Red")
println(s"Got a ${redMini.color} Mini")

abstract class Listener { def trigger }
val myListener = new Listener {
  def trigger { println(s"Trigger at ${new java.util.Date}")}
}
myListener.trigger

abstract class Listener { def trigger }
class Listening {
  var listener: Listener = null
  def register(l: Listener) { listener = l }
  def sendNotification() { listener.trigger }
}
val notification = new Listening()
notification.register(new Listener {
  def trigger { println(s"Trigger at ${new java.util.Date}")}
})
notification.sendNotification

class Printer(msg: String) {
  def print(s: String): Unit = println(s"$msg: $s")
  def print(l: Seq[String]): Unit = print(l.mkString(", "))
}
new Printer("Today's Report").print("Foggy" :: "Rainy" :: "Hot" :: Nil)

class Multiplier(factor: Int) {
  def apply(input: Int) = input * factor
}
val tripleMe = new Multiplier(3)
val tripled = tripleMe.apply(10)
val tripled2 = tripleMe(10)

val l = List('a', 'b', 'c')
val character = l(1)
class RandomPoint {
  val x = { println("creating x"); util.Random.nextInt }
  lazy val y = { println("now y"); util.Random.nextInt }
}
val p = new RandomPoint()
println(s"Location is ${p.x}, ${p.y}")
println(s"Location is ${p.x}, ${p.y}")