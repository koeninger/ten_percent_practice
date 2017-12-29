import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._

object Example {
  def main(args:Array[String]):Unit = {

    def hi(len: Int): List[String] =
      len match {
        case 0 => Nil
        case n => "hi"::hi(n - 1)
      }

    def increment(list: List[Int]): List[Int] =
      list match {
        case Nil => Nil
        case hd::tl => (hd+1)::tl
      }

    def sum(list: List[Int]): Int =
      list match {
        case Nil => 0
        case hd::tl => hd+sum(tl)
      }

    // take any type of list and return the lenght
    def length[A](list: List[A]): Int =
      list match {
        case Nil => 0
        case hd::tl => 1+length(tl)
      }

    println(hi(10))
    println(increment(List(11,22,33,44,55)))
    println(sum(List(2,3,4,1)))
    println(length(List(5,3,"juan",1,"was",3,"here",4,5,6)))

  }
}