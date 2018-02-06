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
  }
}