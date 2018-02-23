package tutorial.webapp

import scala.scalajs.js
import scala.scalajs.js.annotation.{JSName, JSExport}
import org.scalajs.dom
import dom.document
import scala.scalajs.js.annotation.JSExportTopLevel
import org.singlespaced.d3js.d3
import org.singlespaced.d3js.Ops._
import org.singlespaced.d3js.forceModule.Force

trait LinkData extends GraphLink {
  var value: Double = ???
}

trait NodeData extends GraphNode {
  var group: Int = ???
}

trait GraphData extends js.Object {
  var nodes: js.Array[NodeData] = ???
  var links: js.Array[LinkData] = ???
}

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

    val matrix = js.Array(
      js.Array(11975,  5871, 8916, 2868),
      js.Array( 1951, 10048, 2060, 6171),
      js.Array( 8010, 16145, 8090, 8045),
      js.Array( 1013,   990,  940, 6907)
    )

    val tr = d3.select("body").append("table").selectAll("tr")
      .data(matrix)
      .enter().append("tr")

    val td = tr.selectAll("td")
      .data( (d:js.Array[Int]) => { println(d); d; } )
      .enter().append("td")
      .text( (d:Int) => d.toString)

    graph1()
    Graph2.draw()
  }

  def graph1() {
    val d3 = D3Obj.d3
    val color: D3.Scale.OrdinalScale = d3.scale.category20()

    val width:Int = 960
    val height:Int = 500


    val force = d3.layout.force()
      .charge(-120)
      .linkDistance(30)
      .size(Array(width, height))

    val svg = d3.select("body").append("svg")
      .attr("width", width)
      .attr("height", height)

    d3.json("miserables.json", (error: Any, g: js.Any) => {
      dom.console.log("Loaded!!",g)
      val graph = g.asInstanceOf[GraphData]
      force
        .nodes(graph.nodes)
        .links(graph.links)
        .start()

      dom.console.log("Force made")

      val link: Selection = svg.selectAll(".link")
        .data(graph.links)
        .enter().append("line")
        .attr("class", "link")
        .style("stroke-width",(d: LinkData, i: js.Number) => {
        val w = scala.math.sqrt(d.value)
        w.asInstanceOf[js.Dynamic]
      })

      dom.console.log("Link made")


      val node: D3.Selection = svg.selectAll(".node")
        .data(graph.nodes)
        .enter().append("circle")
        .attr("class", "node")
        .attr("r", 5)
        .style("fill", (d: NodeData, i: js.Number) => {
        color(d.group)
      })
        .call(force.drag())

      dom.console.log("Node made")

      node.append("title")
        .text((a: NodeData, _: js.Number) => a.name)

      dom.console.log("Title made")

      def tickFunc = () => {
        link.attr("x1", (d: LinkData) => d.source.x)
          .attr("y1", (d: LinkData) => d.source.y)
          .attr("x2", (d: LinkData) => d.target.x)
          .attr("y2", (d: LinkData) => d.target.y)

        node.attr("cx", (d: GraphNode) => d.x)
          .attr("cy", (d: GraphNode) =>  d.y)
        ()
      }

      force.on("tick", tickFunc)
      ()
    })
  }

}