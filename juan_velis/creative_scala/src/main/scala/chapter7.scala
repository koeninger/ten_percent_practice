import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {

    // Exercise 7.1
    val aBox = Image.rectangle(20, 20).fillColor(Color.royalBlue)

    // Increasing
    val oneBox = aBox
    val twoBoxes = aBox beside oneBox
    // val threeBoxes = aBox beside twoBoxes

    // Better 3 boxes
    val threeBoxes = aBox beside aBox beside aBox


    // Stacking boxes
    def boxes(count: Int): Image =
      count match {
        case 0 => Image.empty
        case n => aBox above boxes(n-1)
      }

    def main(args: Array[String]): Unit = {
      boxes(5).draw
    }

}