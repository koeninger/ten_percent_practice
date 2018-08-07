package algo.ch6

import org.scalatest.FunSuite

import scala.util.Random

class NaryHeapTest extends FunSuite {
  val size = 1000
  test("construction") {
    val h = new NaryHeap(Random.nextInt(size), (1 to size).toArray)
    assert(h.isHeap)
  }

  test("draining") {
    val h = new NaryHeap(Random.nextInt(size), (1 to size).toArray)
    val xs = (1 to size).flatMap(_ => h.pop)
    assert(xs === (size to 1 by -1))
  }

}
