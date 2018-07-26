package algo.ch6

import org.scalatest.FunSuite

import scala.util.Random

class SortTest extends FunSuite {
  val maxSize = math.pow(2, 3).toInt
  // upper bound with a little fudge factor
  val nLogN = maxSize * 1.5 * (math.log(maxSize) / math.log(2))

  def randArray = Array.fill(maxSize)(Random.nextInt)
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
    assert(QuickSort.sort(a) < nLogN)
    assert(a === b.sorted)
  }

  test("quicksort already sorted") {
    val a = randArray.sorted
    assert(QuickSort.sort(a) < nLogN)
  }

  test("quicksort reverse sorted") {
    val a = randArray.sorted.reverse
    assert(QuickSort.sort(a) < nLogN)
  }

  test("quicksort duplicates") {
    val a = randArray.map(x => 23)
    assert(QuickSort.sort(a) < nLogN)
  }

  test("countingsort") {
    val a = randArray.map(x => Random.nextInt(256))
    val b = a.clone
    CountingSort.sort(a, 0, 256)
    assert(a === b.sorted)
  }

  test("selectionsort") {
    val a = randArray
    val b = a.clone
    SelectionSort.sort(a)
    assert(a === b.sorted)
  }
}
