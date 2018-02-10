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

  def polygon(sides:Int, sideLength:Int): Image = {

    val rotation = Angle.one / sides
    def loop(n:Int): List[Instruction] =
      n match {
        case 0 => Nil
        case n => turn(rotation) :: forward(sideLength) :: loop(n-1)
      }

    Turtle.draw(loop(sides))
  }

  polygon.draw
    //Turtle.draw(instructions).draw

  }
}

