package tutorial.webapp

import scala.scalajs.js
import org.scalajs.dom
import dom.document
import scala.scalajs.js.annotation.JSExportTopLevel
import org.singlespaced.d3js.d3
import org.singlespaced.d3js.Ops._

object TutorialApp extends js.JSApp {
  @JSExportTopLevel("addClickedMessage")
  def addClickedMessage(): Unit = {
    appendPar(document.body, "You clicked the button!")
  }
  
  def appendPar(targetNode: dom.Node, text: String): Unit = {
    val parNode = document.createElement("p")
    val textNode = document.createTextNode(text)
    parNode.appendChild(textNode)
    targetNode.appendChild(parNode)
  }

  def main(): Unit = {
    appendPar(document.body, "Hello World!")
    val sel = d3.select("body").append("div")
    sel.style("background-color", "red");

    val rectX = (d: Int, i: Int) => i * 35
    val rectY = (d: Int) => 150 - d * 3
    val rectHeight = (d: Int) => d * 3

    val svg = d3.select("body").append("svg").attr("width", "100%").attr("height", "200px")
    val sel1 = svg.selectAll("rect").data(js.Array(8, 22, 31, 36, 48, 17, 25))
    sel1.enter()
      .append("rect")
      .attr("x", rectX)
      .attr("y", rectY)
      .attr("width", 10)
      .attr("height", rectHeight)
      .style("fill", "yellow")
  }
}