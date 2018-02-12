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

    def randomAngle: Angle = math.random.turns

    def concentricCircles(n: Int, color: Color): Image = {
      var angle = randomAngle
      println(angle)
      n match {
        case 0 => circle(10) fillColor color
        case n => concentricCircles(n-1, color.spin(angle)) on (circle(n * 10) fillColor color)
      }
    }

    concentricCircles(10, Color.red).draw
  }
}

