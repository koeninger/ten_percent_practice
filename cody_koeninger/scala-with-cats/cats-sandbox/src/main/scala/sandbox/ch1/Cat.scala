package sandbox.ch1

import cats.{ Show, Eq }

final case class Cat(name: String, age: Int, color: String)

object Cat {
  implicit val showCat: Show[Cat] = Show.show { a =>
    s"${a.name} is a ${a.age} year-old ${a.color} cat."
  }

  implicit val eqCat: Eq[Cat] = Eq.instance[Cat] { (a, b) =>
    a == b
  }
}

