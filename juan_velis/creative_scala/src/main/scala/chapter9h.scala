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


   def fill[A](n:Int,a:A) : List[A] =
    n match {
      case 0 => Nil
      case n => a :: fill(n-1, a)
    }

   def fill2[A](n:Int,a:A) : List[A] =
    (0 until n).toList.map(x=>a)

   def ones(n:Int) : List[Int] =
    (0 until n).toList.map(x=>1)

   def desc(n:Int) : List[Int] =
    (n until 0 by -1).toList

   def asc(n:Int) : List[Int] =
    (0 until n).toList

   def double(list:List[Int]) : List[Int] =
    list.map(x=>x*2)

    println(increment1(List(11,22,44)))
    println(increment2(List(11,22,44)))
    println(fill(4,"yes"))
    println(fill2(5,"no"))
    println(ones(9))
    println(desc(10))
    println(asc(10))
    println(double(List(1,2,4,8,16)))

  }
}
