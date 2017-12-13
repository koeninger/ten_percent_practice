import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {

  // 8.3 flexible layout
  val dot = Image.circle(5).lineWidth(3).lineColor(Color.crimson)
  val squareDots =
    dot.at(0, 0).
      on(dot.at(0,100)).
      on(dot.at(100,100)).
      on(dot.at(100,0))

  // 8.5 parametric circle sample

  def parametricCircle(angle: Angle): Point =
    Point.polar(200, angle)

  def sample(samples:Int): Image = {
    val step = Angle.one / samples // Angle.one = 360 deg
    val dot = triangle(5, 5)

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

  // 8.5.1 flower example
  def rose(angle: Angle) =
    Point.polar((angle * 7).cos * 200, angle)

  def sample2(samples:Int): Image = {
    val step = Angle.one / samples // Angle.one = 360 deg
    val dot = circle(3)

    def loop(count: Int): Image = {
      val angle = step * count
      count match {
        case 0 => Image.empty
        case n =>
          dot.at(rose(angle).toVec) on loop(n - 1)
      }
    }
    loop(samples)
  }

  def main(args:Array[String]):Unit = {
    squareDots.draw
    sample(72).draw // circle
    sample2(200).draw // flower
  }

}