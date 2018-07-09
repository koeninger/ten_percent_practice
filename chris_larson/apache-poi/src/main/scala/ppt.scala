import org.apache.poi.xslf.usermodel._
import org.apache.poi.sl.usermodel.TableCell.BorderEdge
import org.apache.poi.sl.usermodel.TextParagraph.TextAlign
import java.io.{File, FileOutputStream, FileInputStream}
import java.awt.Color
import java.awt.Rectangle

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

    val titleLayout = defaultMaster.getLayout(SlideLayout.TITLE_AND_CONTENT);
    val slide1 = ppt.createSlide(titleLayout)

    val title1 = slide1.getPlaceholder(0)
    title1.setText("New Slide Title")

    val body1 = slide1.getPlaceholder(1)
    body1.clearText()
    body1.addNewTextParagraph().addNewTextRun().setText("First Paragraph")

    val blankLayout = defaultMaster.getLayout(SlideLayout.BLANK);
    val slide2 = ppt.createSlide(blankLayout)
    val table2 = slide2.createTable()
    table2.setAnchor(new Rectangle(50, 50, 450, 300));
    val headerRow = table2.addRow();
    for (i <- 0 to 2) {
      val th = headerRow.addCell()
      val p = th.addNewTextParagraph()
      p.setTextAlign(TextAlign.CENTER)
      val r = p.addNewTextRun()
      r.setText("Header " + i)
      r.setBold(true)
      r.setFontColor(Color.white)
      th.setFillColor(new Color(79, 129, 189))
      th.setBorderWidth(BorderEdge.bottom, 2.0)
      th.setBorderColor(BorderEdge.bottom, Color.white)

      table2.setColumnWidth(i, 150)
    }


    val fos = new FileOutputStream("slideshow.pptx")
    ppt.write(fos)
    ppt.close()
  }
}