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
