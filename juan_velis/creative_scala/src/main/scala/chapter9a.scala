import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._
import doodle.core.Point._
import doodle.core.PathElement._

object Example {
  def main(args:Array[String]):Unit = {

    val triangle =
      List(
        lineTo(cartesian(50, 100)),
        lineTo(cartesian(100, 0)),
        lineTo(cartesian(0, 0))
      )

    val curve =
      List(curveTo(
            cartesian(50,100),
            cartesian(100,100),
            cartesian(150,0))
          )

    // style an image
    def style(image: Image): Image =
      image.
        lineWidth(6.0).
        lineColor(Color.blue).
        fillColor(Color.yellow)

    val openPaths =
      style(openPath(triangle) beside openPath(curve))

    val closedPaths =
      style(closedPath(triangle) beside closedPath(curve))

    val paths = openPaths above closedPaths

    paths.draw
  }
}