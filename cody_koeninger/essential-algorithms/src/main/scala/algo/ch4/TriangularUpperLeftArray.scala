package algo.ch4

import scala.collection.mutable.StringBuilder
import scala.reflect.ClassTag

class TriangularUpperLeftArray[T: ClassTag](val rows: Int) {
  private def numCells(n: Int): Int = ((n + math.pow(n, 2)) / 2).toInt
  private val a = new Array[T](numCells(rows))

  private def index(x: Int, y: Int): Int = {
    val r = a.size - 1 - numCells(rows - 1 - y) - ((rows - 1 - y) - x)
    println(s"index for ($x, $y) is $r")
    r
  }

  def apply(x: Int, y: Int): T = {
    a(index(x, y))
  }

  def update(x: Int, y: Int, rhs: T): Unit = {
    a(index(x, y)) = rhs
  }

  def toDebugString: String = {
    val s = new StringBuilder
    for (y <- 0 until rows) {
      for (x <- 0 until (rows - y)) {
        s ++= s"${apply(x, y)}"
      }
      for (t <- (rows - y) until rows) {
        s ++= "_"
      }
      s ++= "\n"
    }
    s.toString
  }
}
