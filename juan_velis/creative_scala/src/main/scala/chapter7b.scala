import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._

object Example {
    val cir = Image.circle(10)
    val black = Image.rectangle(10,10).fillColor(Color.black)
    val red = Image.rectangle(10,10).fillColor(Color.red)
    val square = (black beside red) above (red beside black)

    // 7.4 Cross
    def cross(count: Int): Image =
      count match {
        case 0 => cir
        case n => cir beside (cir below cross(n-1) below cir) beside cir
      }

   // 7.4 Chess
    def chess(count: Int): Image =
      count match {
        case 0 => square
        case n => var squares = chess(n-1)
            (squares beside squares) above (squares beside squares)
      }

    def main(args: Array[String]): Unit = {
      cross(5).draw
      chess(3).draw
    }


    def main(args: Array[String]): Unit = {
      boxes(5).draw
    }
}
