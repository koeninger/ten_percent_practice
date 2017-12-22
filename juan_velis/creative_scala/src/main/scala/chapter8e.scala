import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {

  // draw circle with variable radius depending on a ratio
  def particle(minR: Int, maxR: Int, ratio: Normalized): Normalized => Image =
    (r: Normalized) => {
      val size = minR + (r.get * (maxR - minR))
      circle(size).noFill
    }

  // polar to xy
  def position(k: Int): Angle => Point =
    (angle: Angle) => {
      Point.cartesian((angle * k).cos * angle.cos, (angle * k).cos * angle.sin)
    }

  // scale a polar point
  def scale(factor: Double): Point => Point =
    (pt: Point) => {
      Point.polar(pt.r * factor, pt.angle)
    }

  def point(position: Angle => Point, scale: Point => Point, image: Normalized => Image, rota: Angle): Angle => Image = {
    (angle: Angle) => {
      val pt = position(angle)
      val scaledPt = scale(pt)
      val r = pt.r.normalized
      val img = image(r)

      (img at scaledPt.toVec.rotate(rota))
    }
  }

  def iterate(step: Angle): (Angle => Image) => Image = {
    (point: Angle => Image) => {
      def iter(angle: Angle): Image = {
        if(angle > Angle.one) // angle.one = 360 deg
          Empty
        else
          point(angle) on iter(angle + step)
      }
      iter(Angle.zero)
    }
  }

  def main(args:Array[String]):Unit = {
    val shape =
      iterate(1.degrees){
        point(
          position(5),
          scale(200.0),
          particle(2, 20, 0.2.normalized),
          0.degrees
        )
      }.fillColor(Color.fuchsia).lineColor(Color.fuchsia)

    val shapeTwo =
      iterate(1.degrees){
        point(
          position(5),
          scale(150.0),
          particle(2, 10, 0.3.normalized),
          20.degrees
        )
      }.fillColor(Color.green).lineColor(Color.green)

    val shapeThree =
      iterate(1.degrees){
        point(
          position(5),
          scale(200.0),
          particle(2, 10, 0.3.normalized),
          40.degrees
        )
      }.fillColor(Color.red).lineColor(Color.red)

    (shape on shapeTwo on shapeThree).draw
  }

}