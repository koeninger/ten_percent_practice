import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {

  // Exercise 3.4.4
  val triangles = (triangle(100,100) fillColor(Color.red) above (triangle(100,100) fillColor(Color.red darken 0.2.normalized) beside triangle(100,100)) fillColor(Color.red darken 0.4.normalized))
  val target1 = (((circle(10) fillColor Color.red) on (circle(20) fillColor Color.white) on (circle(30) fillColor Color.red)) above (triangle(40,40) fillColor Color.brown)) above (rectangle(60,10) fillColor Color.green)

  def main(args: Array[String]): Unit = {
    triangles.draw
    target1.draw
  }
}
