import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {

  // 7.7 Nested Methods

  def chessboard(count: Int): Image = {
    val black = Image.rectangle(10,10) fillColor Color.black
    val red = Image.rectangle(10,10) fillColor Color.red
    val square = ((red beside black) above (black beside red))

    def loop(count: Int): Image =
      count match {
        case 0 => square
        case n =>
          val unit = loop(n-1)
          (unit beside unit) above (unit beside unit)
      }
      loop(count)
  }

  def boxes(count: Int): Image = {
    val box = Image.rectangle(10,10).fillColor(Color.red)
    def loop(count: Int): Image =
      count match {
        case 0 => Image.empty
        case n => box beside loop(n-1)
      }
    loop(count)
  }

  def main(args:Array[String]):Unit = {
    chessboard(2).draw
    boxes(3).draw
  }

}