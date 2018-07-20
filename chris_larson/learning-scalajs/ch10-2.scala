object IntUtils {
  implicit class Fishies(val x: Int) {
    def fishes = "Fish" * x
  }
}

import IntUtils._
println(3.fishes)

implicit class ArrowAssoc[A](x: A) {
  def ->[B](y: B) = Tuple2(x, y)
}

1 -> "a"

object TypeFun {
  type Whole = Int
  val x: Whole = 5

  type UserInfo = Tuple2[Int, String]
  val u: UserInfo = new UserInfo(123, "George")

  type T3[A,B,C] = Tuple3[A,B,C]
  val things = new T3(1, 'a', true)
}

val x = TypeFun.x
val u = TypeFun.u 
val things = TypeFun.things 

class User(val name: String)
trait Factory { type A; def create: A }
trait UserFactory extends Factory {
  type A = User 
  def create = new User("") 
}

trait Factory[A] {def create: A }
trait UserFactory extends Factory[User] { def create = new User("") }

class BaseUser(val name: String)
class Admin(name: String, val level: String) extends BaseUser(name)
class Customer(name: String) extends BaseUser(name)
class PreferredCustomer(name: String) extends BaseUser(name)

def check[A <: BaseUser](u: A) { if (u.name.isEmpty) println("Fail!") }
check(new Customer("Fred"))
check(new Admin("", "strict"))
