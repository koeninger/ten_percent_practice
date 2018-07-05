import org.apache.poi.xslf.usermodel._
import java.io.{File, FileOutputStream}

object Hello {
  def main(args: Array[String]) {
    import scala.collection.JavaConversions._

    val ppt = new XMLSlideShow();
    val blankSlide = ppt.createSlide();
    val fos = new FileOutputStream("SampleSS-updated.pptx")
    ppt.write(fos)
    ppt.close()
    println("Hello from Apache POI")

  }
}