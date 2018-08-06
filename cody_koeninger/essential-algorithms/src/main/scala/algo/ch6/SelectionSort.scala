package algo.ch6

import scala.math.Ordering

object SelectionSort {
  def swap[T](a: Array[T], i: Int, j: Int): Unit = {
    val tmp = a(i)
    a(i) = a(j)
    a(j) = tmp
  }

  /* destructive sort of a */
  def sort[T](a: Array[T])(implicit ord: Ordering[T]): Unit = {
    var m = 0
    (0 until a.size).foreach { i =>
      m = i
      (i until a.size).foreach { j =>
        if (ord.lt(a(j), a(m))) {
          m = j
        }
      }
      swap(a, i, m)
    }
  }
}
