import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {

  // Exercise 4.4
  val coloredTarget =
    (
      circle(10).fillColor(Color.red) on
      circle(20).fillColor(Color.white) on
      circle(30).fillColor(Color.red)
    )

  val stand = triangle(40,40).fillColor(Color.brown)

  val ground = rectangle(80, 25).lineWidth(0).fillColor(Color.green)

  val image = coloredTarget above stand above ground


  // Exercise 4.5
  val house =
    triangle(50,15) fillColor Color.brown above
    (rectangle(50,15) fillColor Color.red) above (
      (rectangle(10,20) fillColor Color.black) on
      (rectangle(50,20) fillColor Color.red)
    )
  val tree =
    (
      (circle(20) fillColor Color.green) above
      (rectangle(10,10) fillColor Color.brown)
    )
  val street =
    (
      rectangle(15, 2) fillColor Color.yellow beside
      rectangle(35, 2) fillColor Color.black
    )
  val fullstreet = street beside street beside street
  val fullhouse =
    (house beside tree) above fullstreet

  val image2 = fullhouse beside fullhouse beside fullhouse

    def main(args: Array[String]): Unit = {
      image.draw
      image2.draw
    }
}