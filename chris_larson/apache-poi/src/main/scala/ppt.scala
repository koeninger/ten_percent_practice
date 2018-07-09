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
    
    val defaultMaster = ppt.getSlideMasters().get(0)
    val slides = ppt.getSlides()
    val chart = slides.get(1)
    chart.getPlaceholder(0).setText("Chart Title")

    val titleLayout = defaultMaster.getLayout(SlideLayout.TITLE_AND_CONTENT);
    val slide1 = ppt.createSlide(titleLayout)
    val title1 = slide1.getPlaceholder(0)
    title1.setText("New Slide Title")
    val body1 = slide1.getPlaceholder(1)
    body1.clearText()
    body1.addNewTextParagraph().addNewTextRun().setText("First Paragraph")
    val fos = new FileOutputStream("SampleSS-updated.pptx")
    ppt.write(fos)
    ppt.close()
  }
}