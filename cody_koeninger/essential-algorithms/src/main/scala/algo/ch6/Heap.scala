package algo.ch6

import scala.math.Ordering

object Heap {
  def parent(i: Int): Int = math.floor((i - 1) / 2.0).toInt

  def leftChild(i: Int): Int = (2 * i) + 1

  def rightChild(i: Int): Int = (2 * i) + 2

  def isHeap[T](a: Array[T])(implicit ord: Ordering[T]): Boolean = {
    (0 until a.size).forall { i =>
      val lc = leftChild(i)
      val rc = rightChild(i)
      ((a.size <= lc) || (ord.gteq(a(i), a(lc)))) &&
        ((a.size <= rc) || (ord.gteq(a(i), a(rc))))
    }
  }

  def swap[T](a: Array[T], i: Int, j: Int): Unit = {
    val tmp = a(i)
    a(i) = a(j)
    a(j) = tmp
  }

  def makeHeap[T](a: Array[T])(implicit ord: Ordering[T]): Unit = {
    (0 until a.size).foreach { i =>
      var j = i
      while (j != 0) {
        val p = parent(j)
        if (ord.lt(a(p), a(j))) {
          swap(a, p, j)
          j = p
        } else {
          j = 0
        }
      }
    }
  }

  /* assumes top / leftmost item is only one out of place, push it down to correct place */
  def fixHeap[T](a: Array[T], rightmost: Int)(implicit ord: Ordering[T]): Unit = {
    var p = 0
    var done = false
    while (!done) {
      val lc = {
        val x = leftChild(p)
        if (rightmost <= x) p else x
      }
      val rc = {
        val x = rightChild(p)
        if (rightmost <= x) p else x
      }
      if (rightmost <= p ||
        (ord.gteq(a(p), a(lc)) && ord.gteq(a(p), a(rc)))) {
        done = true
      } else {
        val c = if (ord.gteq(a(lc), a(rc))) lc else rc
        swap(a, p, c)
        p = c
      }
    }
  }

  def heapSort[T](a: Array[T])(implicit ord: Ordering[T]): Unit = {
    makeHeap(a)
    (a.size - 1 until 0 by -1).foreach { rightmost =>
      swap(a, 0, rightmost)
      fixHeap(a, rightmost)
    }
  }

}
