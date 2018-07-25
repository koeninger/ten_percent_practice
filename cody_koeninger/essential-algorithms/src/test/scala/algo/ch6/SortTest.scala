package algo.ch6

import org.scalatest.FunSuite

import scala.util.Random

class SortTest extends FunSuite {
  def randArray = Array.fill(100)(Random.nextInt)
  test("makeheap") {
    val a = randArray
    Heap.makeHeap(a)
    assert(Heap.isHeap(a))
  }

  test("heapsort") {
    val a = randArray
    val b = a.clone
    Heap.heapSort(a)
    assert(a === b.sorted)
  }

  test("mergesort") {
    val a = randArray
    val b = a.clone
    MergeSort.sort(a)
    assert(a === b.sorted)
  }

  test("choosePivot") {
    val left = Random.nextInt(256)
    val right = Random.nextInt(256) + left
    val p = QuickSort.choosePivot(left, right)
    assert(left <= p && p <= right)
  }

  test("quicksort") {
    val a = randArray
    val b = a.clone
    QuickSort.sort(a)
    assert(a === b.sorted)
  }

}
