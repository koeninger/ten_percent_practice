class User
val u = new User
val isAnyRef = u.isInstanceOf[AnyRef]

class User {
  val name: String = "Yubba"
  def greet: String = s"Hello from $name"
  override def toString = s"User ($name)"
}

val u = new User
println(u.greet)

class User(n: String) {
  val name: String = n
  def greet: String = s"Hello from $name"
  override def toString = s"User($name)"
}
val u = new User("Zeniba")
println(u.greet)

class User(val name: String) {
  def greet: String = s"Hello from $name"
  override def toString = s"User($name)"
}
val users = List(new User("Shoto"), new User("Art3mis"), new User("Aesch"))
val sizes = users map (_.name.size)
val sorted = users sortBy (_.name)
val third = users find (_.name contains "3")
val greet = third map (_.greet) getOrElse "hi"

class A {
  def hi = "Hello from A"
  override def toString = getClass.getName
}
class B extends A
class C extends B {
  override def hi = "hi C -> " + super.hi
}

val hiA = new A().hi
val hiB = new B().hi
val hiC = new C().hi
