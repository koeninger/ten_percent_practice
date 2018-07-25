package algo.ch6

import org.scalatest.FunSuite

import scala.util.Random

class SortTest extends FunSuite {
  def randArray = Array.fill(10)(Random.nextInt)
  test("makeheap") {
    val a = randArray
    Sort.makeHeap(a)
    assert(Sort.isHeap(a))
  }

  test("heapsort") {
    val a = randArray
    val b = a.clone
    Sort.heapSort(a)
    assert(a === b.sorted)
  }
}
