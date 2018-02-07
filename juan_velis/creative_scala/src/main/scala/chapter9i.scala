import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._

object Example {
  def main(args:Array[String]):Unit = {


    // old ascending w recursion
    def ascending1(n: Int, c: Int): List[Int] =
      n match {
        case 0 => Nil
        case n => c::ascending1(n-1, c+1)
      }

    // ascending using lists
    def ascending2(n: Int): List[Int] = (1 to n).toList

    println(ascending1(5, 1))
    println(ascending2(5))
  }
}