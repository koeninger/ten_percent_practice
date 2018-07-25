case class Car() { override def toString = "Car()" }
class Volvo extends Car { override def toString = "Volvo()" }
val c: Car = new Volvo()

case class Item[A](a: A) { def get: A = a }
val c: Item[Car] = new Item[Volvo](new Volvo)

case class Item[+A](a: A) { def get: A = a }
val c: Item[Car] = new Item[Volvo](new Volvo)
val auto = c.get