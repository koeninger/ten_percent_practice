import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._
import doodle.core.Point._
import doodle.core.PathElement._

object Example {
  def main(args:Array[String]):Unit = {


    def curve(radius: Int, start: Angle, increment: Angle): PathElement = {
      curveTo(
        polar(radius *  .8, start + (increment * .3)),
        polar(radius * 1.2, start + (increment * .6)),
        polar(radius, start + increment)
      )
    }

    val triangle = List(
                   moveTo(polar(100,0.degrees)),
                   curve(100,0.degrees, 120.degrees),
                   curve(100,120.degrees, 120.degrees),
                   curve(100,240.degrees, 120.degrees)
                  )

    val square = List(
                   moveTo(polar(100, 45.degrees)),
                   curve(100, 45.degrees, 90.degrees),
                   curve(100, 135.degrees, 90.degrees),
                   curve(100, 225.degrees, 90.degrees),
                   curve(100, 315.degrees, 90.degrees)
                 )

    val pentagon = List(
                    moveTo(polar(100, 72.degrees)),
                    curve(100, 72.degrees, 72.degrees),
                    curve(100, 144.degrees, 72.degrees),
                    curve(100, 216.degrees, 72.degrees),
                    curve(100, 288.degrees, 72.degrees),
                    curve(100, 360.degrees, 72.degrees)
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