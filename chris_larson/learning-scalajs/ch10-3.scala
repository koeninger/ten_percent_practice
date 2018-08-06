case class Car() { override def toString = "Car()" }
class Volvo extends Car { override def toString = "Volvo()" }
val c: Car = new Volvo()

case class Item[A](a: A) { def get: A = a }
val c: Item[Car] = new Item[Volvo](new Volvo)

case class Item[+A](a: A) { def get: A = a }
val c: Item[Car] = new Item[Volvo](new Volvo)
val auto = c.get

class Check[+A] { def check(a: A) = {} }
class Check[-A] { def check(a: A) = {} }

class Car; class Volvo extends Car; class VolvoWagon extends Volvo
class Item[+A](a: A) { def get: A = a }
class Check[-A] { def check(a: A) = {} }
def item(v: Item[Volvo]) { val c: Car = v.get }
def check(v: Check[Volvo]) { v.check(new VolvoWagon)}

item( new Item[Car](new Car()) )
item( new Item[Volvo](new Volvo) )
item( new Item[VolvoWagon](new VolvoWagon()) )
check( new Check[Car]() )
check( new Check[Volvo]() )
check( new Check[VolvoWagon]() )