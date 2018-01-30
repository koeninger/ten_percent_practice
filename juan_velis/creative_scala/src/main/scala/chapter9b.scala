import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._
import doodle.core.Point._
import doodle.core.PathElement._

object Example {
  def main(args:Array[String]):Unit = {

    val triangle = List(
                   lineTo(polar(100,0.degrees)),
                   lineTo(polar(100,120.degrees)),
                   lineTo(polar(100,240.degrees))
                  )

    val square = List(
                   lineTo(polar(100, 45.degrees)),
                   lineTo(polar(100, 135.degrees)),
                   lineTo(polar(100, 225.degrees)),
                   lineTo(polar(100, 315.degrees))
                 )

    val pentagon = List(
                    lineTo(polar(100, 72.degrees)),
                    lineTo(polar(100, 144.degrees)),
                    lineTo(polar(100, 216.degrees)),
                    lineTo(polar(100, 288.degrees)),
                    lineTo(polar(100, 360.degrees))
                  )

    // style an image
    def style(image: Image): Image =
      image.
        lineWidth(6.0).
        lineColor(Color.blue).
        fillColor(Color.yellow)

    val paths =
      style(
        closedPath(triangle) beside
        closedPath(square) beside
        closedPath(pentagon)
      )

    paths.draw
  }
}