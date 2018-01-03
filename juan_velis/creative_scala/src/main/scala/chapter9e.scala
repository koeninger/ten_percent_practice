import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._

object Example {
  def main(args:Array[String]):Unit = {

    // ex. 9.2 Building lists

    def ones(n: Int): List[Int] =
      n match {
        case 0 => Nil
        case n => 1::ones(n-1)
      }

    def descending(n: Int): List[Int] =
      n match {
        case 0 => Nil
        case n => n::descending(n-1)
      }

    def ascending(n: Int, c: Int): List[Int] =
      n match {
        case 0 => Nil
        case n => c::ascending(n-1, c+1)
      }

    def fill[A](n: Int, a:A): List[A] =
      n match {
        case 0 => Nil
        case n => a::fill(n - 1, a)
      }

    println(ones(5))
    println(descending(5))
    println(ascending(5, 1))
    println(fill(5, "yes"))

  }
}