import org.apache.poi.xslf.usermodel._
import java.io.{File, FileOutputStream, FileInputStream}

object Hello {
  def main(args: Array[String]) {
    import scala.collection.JavaConversions._

    val ppt = new XMLSlideShow(new FileInputStream("slideshow-template.pptx"));
    println("Available slide layouts: ")
    for( master <- ppt.getSlideMasters()){
      for( layout <- master.getSlideLayouts()) {
        println(layout.getType())
      }
    }
    val slide1 = ppt.createSlide();
    val fos = new FileOutputStream("SampleSS-updated.pptx")
    ppt.write(fos)
    ppt.close()
    println("Hello from Apache POI")

  }
}