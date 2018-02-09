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

    var sides = 12;
    def loop(n:Int): List[Instruction] =
      n match {
        case 0 => Nil
        case n => turn(360.degrees / sides) :: forward(40) :: loop(n-1)
      }

    Turtle.draw(loop(sides)).draw
  }
}

