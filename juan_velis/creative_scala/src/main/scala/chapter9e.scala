import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._

object Example {
  def main(args:Array[String]):Unit = {

    // ex. 9.2 Building lists

    def ones(n: Int): List[Int] =
      n match {
        case 0 => Nil
        case n => 1::ones(n-1)
      }

    def descending(n: Int): List[Int] =
      n match {
        case 0 => Nil
        case n => n::descending(n-1)
      }

    def ascending(n: Int, c: Int): List[Int] =
      n match {
        case 0 => Nil
        case n => c::ascending(n-1, c+1)
      }

    def fill[A](n: Int, a:A): List[A] =
      n match {
        case 0 => Nil
        case n => a::fill(n - 1, a)
      }

    def double(list:List[Int]):List[Int] = {
      list match {
        case Nil => Nil
        case a::z => (a*2)::double(z)
      }
    }

    def product(list:List[Int]):Int = {
      list match {
        case Nil => 1
        case a::z => a*product(z)
      }
    }

    def contains[A](list:List[A], findthis:A):Boolean = {
      list match {
        case Nil => false
        case a::z => (if (a == findthis) true else false) || contains(z, findthis)
      }
    }

    def first[A](list:List[A], default:A):A = {
      list match {
        case Nil => default
        case a::z => a
      }
    }

    def reverse[A](list: List[A], revlist: List[A]): List[A] = {
      // println(list, revlist)
      list match {
        case Nil => revlist
        case a::z => reverse(z, a :: revlist)
      }
    }

    println(ones(5))
    println(descending(5))
    println(ascending(5, 1))
    println(fill(5, "yes"))

    println(double(List(11,22,33,44,55)))
    println(product(List(2,3,6)))
    println(contains(List(2,3,6),9))
    println(contains(List(2,3,6),6))
    println(first(List(2,3,6),6))
    println(reverse(List(2,3,6,8,11,1000), Nil))

  }
}