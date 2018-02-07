import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._
import doodle.core.Point._
import doodle.core.PathElement._
import scala.util.Random._

object Example {
  def main(args:Array[String]):Unit = {

    // style
    def style(image: Image): Image = {
      val colors = Array(Color.red, Color.yellow, Color.green, Color.blue, Color.pink, Color.brown, Color.orange)
      val color = colors(nextInt(7)) // pick a random color from the array
      image.
        lineWidth(2.0).
        lineColor(Color.black).
        fillColor(color)
    }

    def star(sides: Int, skip: Int, radius: Double): Image = {
      val rotation = 360.degrees * skip / sides
      val start = moveTo(polar(radius, 0.degrees))
      val elements = (1 until sides).toList map { index =>
        val point = polar(radius, rotation * index)
        lineTo(point)
      }
      closedPath(start :: elements) lineWidth 2
    }

    def multiple(n:Int):Image = {
      n match {
        case n if(n<=2) =>
          Image.empty
        case n =>
          multiple(n-1) beside style(star(11, n, 30))
      }
    }

    def multiple2(c:Int):Image = {
      c match {
        case c if(c<1) =>
          Image.empty
        case c =>
          multiple2(c-1) above multiple(c)
      }
    }

    multiple2(11).draw
  }
}