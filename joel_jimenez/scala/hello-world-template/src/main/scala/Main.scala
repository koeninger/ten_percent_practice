// Chapter 5
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.BasicStroke;
import java.awt.geom.Path2D;
import java.awt.Color;

object Main extends App {
  def drawImage(g: Graphics2D): Unit = {
    g.setStroke(new BasicStroke(1.0f))
    g.setPaint(new Color(0, 0, 0))
    val path = new Path2D.Double()
    path.moveTo(25, 0)
    path.lineTo(50, 50)
    path.lineTo(0, 50)
    path.lineTo(25, 0)
    path.closePath()
    g.draw(path)
  }
}
