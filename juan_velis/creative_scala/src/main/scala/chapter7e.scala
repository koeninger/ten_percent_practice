import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {

   // 7.6 boxes with paramaters
    def boxes(x:Int, size:Int):Image =
      x match {
        case 0 => Image.empty
        case n => Image.rectangle(size,size) beside boxes(n-1,size+5)
      }

    def colorboxes(x:Int, color:Color):Image =
      x match {
        case 0 => Image.empty
        case n => Image.rectangle(20,20).fillColor(color) beside colorboxes(n-1,color.spin(20.degrees))
      }

    def nestedcircles(count:Int, r:Int):Image =
      count match {
        case 0 => Image.empty
        case n => Image.circle(r).lineColor(Color.blue) on nestedcircles(n-1,r+5)
      }

    def colorcircles(count:Int, r:Int, color:Color):Image =
      count match {
        case 0 => Image.empty
        case n => Image.circle(r).lineColor(color) on colorcircles(n-1,r+7,color.spin(5.degrees))
      }

    def main(args:Array[String]):Unit = {
      boxes(5, 5).draw
      colorboxes(5, Color.blue).draw
      nestedcircles(10,30).draw
      colorcircles(10,30,Color.red).draw
    }

}