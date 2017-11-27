import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {

  // Exercise 6.2
  def square(number:Int):Int = {
    number * number
  }

  def halve(number:Double):Double = {
    number / 2.0
  }

  def parametertest(x:Int, y:Int):Int = {
    print("sanity")
    x + y
  }

  // parametertest({println("a");1},{println("a");2})

}