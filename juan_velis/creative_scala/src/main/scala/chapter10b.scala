import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._
import doodle.core.Point._
import doodle.core.PathElement._
import scala.util.Random._
import doodle.turtle._
import doodle.turtle.Instruction._

object Example {
  def main(args:Array[String]):Unit = {

    def loop(n:Int, dist:Float): List[Instruction] =
      n match {
        case 0 => Nil
        case n => turn(89.degrees) :: forward(dist) :: loop(n-1, dist + 2)
      }

    Turtle.draw(loop(100, 5)).draw

  }
}
