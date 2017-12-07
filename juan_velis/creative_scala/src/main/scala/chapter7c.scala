import doodle.core._
import doodle.core.Image._
import doodle.syntax._
import doodle.jvm.Java2DFrame._
import doodle.backend.StandardInterpreter._


object Example {
    val tri = Image.triangle(5,5) // one triangle
    val tri3 = tri above (tri beside tri) // three triangles

   // 7.4 fractal
    def fractal(count: Int): Image =
      count match {
        case 0 => tri3
        case n => var tris = fractal(n-1)
          (tris) above (tris beside tris)
      }

    def main(args: Array[String]): Unit = {
      fractal(3).draw
    }

}