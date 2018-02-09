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

    val instructions: List[Instruction] =
      List(forward(50), turn(90.degrees),
        forward(50), turn(90.degrees),
        forward(50), turn(90.degrees),
        forward(50))

    Turtle.draw(instructions).draw

  }
}

