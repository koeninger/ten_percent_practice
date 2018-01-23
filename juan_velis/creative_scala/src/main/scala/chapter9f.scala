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


    def polygon(sides: Int, size: Int): Image = {
      def loop(n: Int, rotation: Angle): List[PathElement] =
        n match {
          case 0 =>
            Nil
          case n =>
            LineTo(polar(size, rotation * n)) :: loop(n - 1, rotation)
        }
      style(closedPath(moveTo(polar(size, 0.degrees)) :: loop(sides, 360.degrees / sides)))
    }


    def multiple(n:Int):Image = {
      n match {
        case n if(n<=2) =>
          Image.empty
        case n =>
          multiple(n-1) on polygon(n, 10 * n)
      }
    }

    multiple(30).draw
  }
}