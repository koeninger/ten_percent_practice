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

    def increment1(list:List[Int]) : List[Int] =
      list match {
        case Nil => Nil
        case hd :: tl => (hd + 1) :: tl
      }


   def increment2(list:List[Int]) : List[Int] =
    list.map(x=>x+1)

    println(increment1(List(11,22,44)))
    println(increment2(List(11,22,44)))

  }
}

}