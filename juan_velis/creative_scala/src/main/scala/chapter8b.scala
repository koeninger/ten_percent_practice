import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {

  // 8.6 functions

  def rose(angle: Angle) =
    Point.cartesian((angle * 7).cos * angle.cos, (angle * 7).cos * angle.sin)

  def main(args:Array[String]):Unit = {
    val roseFn = rose _ // Ex. 1. Convert the rose method to function with the _ operator. Input: Angle, Returns: Point.
    val add45 = (x: Int) => x + 45
    val double = (x: Int) => x * 2
    val combined = add45 andThen double
    val roseFnLit = (a:Angle) => Point.cartesian((a * 7).cos * a.cos, (a * 7).cos * a.sin) // Ex 2.

    println(roseFn(0.degrees)) // Cartesian(1.0,0.0)
    println(add45(10)) // 55
    println(combined(5)) // 100
    println(roseFnLit(0.degrees)) // Cartesian(1.0,0.0)
  }

}