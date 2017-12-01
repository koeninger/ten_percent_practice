package sandbox.ch1

import cats.{ Show, Eq }
import cats.syntax.show._
import cats.syntax.eq._
import cats.instances.option._
import cats.syntax.option._

object UseCats {
  def main(args: Array[String]): Unit = {
    val cat = Cat("garfield", 23, "orange")
    val cat2 = Cat("bowser", 30, "green")

    println(Show[Cat].show(cat))
    println(cat.show)

    Eq[Cat].eqv(cat, cat2)
    cat === cat2

    cat.some === cat2.some
  }
}
