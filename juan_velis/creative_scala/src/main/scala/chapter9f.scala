import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._
import doodle.core.Point._
import doodle.core.PathElement._

object Example {
  def main(args:Array[String]):Unit = {

    // Polygon

    // style
    def style(image: Image): Image =
      image.
        lineWidth(1.0).
        lineColor(Color.blue).
        fillColor(Color.yellow)


    def polygon(sides: Int, size: Int): Image = {
      def loop(n: Int, rotation: Angle): List[PathElement] =
        n match {
          case 0 =>
            Nil
          case n =>
            LineTo(polar(size, 0.degrees)) :: loop(n - 1, rotation)
        }

      closedPath(moveTo(polar(size, initialRotation)) :: loop(sides, 360.degrees / sides))
    }


    polygon(5,30).draw
  }
}
