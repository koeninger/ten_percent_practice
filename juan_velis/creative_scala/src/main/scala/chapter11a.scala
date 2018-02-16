import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._
import doodle.core.Point._
import doodle.core.PathElement._
import scala.util.Random._
import doodle.random._

object Example {
  def main(args:Array[String]):Unit = {

    def randomAngle: Angle = math.random.turns

    def concentricCircles(n: Int, color: Color): Image = {
      var angle = randomAngle
      println(angle)
      n match {
        case 0 => circle(10) fillColor color
        case n => concentricCircles(n-1, color.spin(angle)) on (circle(n * 10) fillColor color)
      }
    }

    def randomAngle2: Random[Angle] = Random.double.map(x => x.turns)
    def randomColor(s: Normalized, l: Normalized): Random[Color] = randomAngle2 map (hue => Color.hsl(hue, s, l))
    def randomCircle(r: Double, color: Random[Color]): Random[Image] = color map (fill => Image.circle(r) fillColor fill)

    concentricCircles(10, Color.red).draw

    println(randomAngle2.run)
    println(randomColor(0.5.normalized, 0.5.normalized).run)
    randomCircle(50, randomColor(0.5.normalized, 0.5.normalized)).run.draw

  }
}

