import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {

  // 8.8 Exercises

  def parametricCircle(angle: Angle): Point =
    Point.polar(200, angle)

  def sample(samples:Int): Image = {
    val step = Angle.one / samples // Angle.one = 360 deg
    val dot = circle(3)

    def loop(count: Int): Image = {
      val angle = step * count
      count match {
        case 0 => Image.empty
        case n =>
          dot.at(parametricCircle(angle).toVec) on loop(n - 1)
      }
    }

    loop(samples)
  }

  // abstracting sample by adding
  def sample3(samples: Int, location: Angle => Point): Image = {
    val step = Angle.one / samples
    val dot = circle(3)
    def loop(count: Int): Image = {
      val angle = step * count
      count match {
        case 0 => Image.empty
        case n =>
          dot.at(location(angle).toVec) on loop(n - 1)
      }
    }
    loop(samples)
  }


  // abstract the circle image out of the recursion
  def parametricCircle2(angle: Angle): Image =
    circle(3).at(Point.polar(200, angle).toVec)

  def sample4(samples: Int, location: Angle => Image): Image = {
    val step = Angle.one / samples
    def loop(count: Int): Image = {
      val angle = step * count
      count match {
        case 0 => Image.empty
        case n => location(angle) on loop(n - 1)
      }
    }
    loop(samples)
  }



  def main(args:Array[String]):Unit = {
    //sample(72).draw
    //sample3(72, parametricCircle).draw
    sample4(72, parametricCircle2).draw
  }

}