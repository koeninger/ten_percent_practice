import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {

  // 8.7 higher order methodds & functions

  def circles(n: Int): Image =
    Image.circle(20*n) lineColor Color.red

  def triangles(n: Int): Image =
    Image.triangle(20*n, 20*n) lineColor Color.red

  def squares(n: Int): Image =
    Image.square(20*n) lineColor Color.red

  def concentricShapes(count: Int, singleShape: Int => Image): Image =
    count match {
      case 0 => Image.empty
      case n => singleShape(n) on concentricShapes(n-1, singleShape)
    }

  def main(args:Array[String]):Unit = {
    concentricShapes(5, triangles _).draw
    concentricShapes(5, squares _).draw
    concentricShapes(5, circles _).draw
  }

}