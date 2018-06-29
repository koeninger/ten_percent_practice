package algo.ch2

import scalafx.Includes._
import scalafx.application.JFXApp
import scalafx.application.JFXApp.PrimaryStage
import scalafx.collections.ObservableBuffer
import scalafx.scene.Scene
import scalafx.scene.chart._
import scalafx.scene.layout.StackPane

import Ex.FairDie

object Graph2d6 extends JFXApp {
  val iterations = 100000

  stage = new PrimaryStage {
    scene = new Scene(800, 600) {
      root = new LineChart(NumberAxis("roll"), NumberAxis("count")) {
        title = s"2d6 $iterations iterations"
        data = rolls(iterations)
      }
    }
  }

  def rolls(iterations: Int) = {
    val d6 = new FairDie(6)
    val hist = new Array[Long](13)
    (1 to iterations).foreach { i =>
      hist(d6() + d6()) += 1
    }
    XYChart.Series(
      ObservableBuffer(
        (2 to 12).map { i =>
          XYChart.Data[Number, Number](i, hist(i))
        }))
  }
}
