package algo.ch6

import scala.math.Ordering

/* heap with N children at each node, destructively modifies a */
class NaryHeap[T](val n: Int, a: Array[T])(implicit ord: Ordering[T]) {
  private var rightmost = a.size - 1

  private def parent(i: Int): Int = math.floor((i - 1.0) / n).toInt

  private def children(i: Int): IndexedSeq[Int] = {
    val m = i * n
    (1 until n).map(x => m + x).filter(_ <= rightmost)
  }

  def isHeap: Boolean = {
    (0 until a.size).forall { i =>
      children(i).forall { c =>
        ord.gteq(a(i), a(c))
      }
    }
  }

  private def swap(i: Int, j: Int): Unit = {
    val tmp = a(i)
    a(i) = a(j)
    a(j) = tmp
  }

  def pop: Option[T] = {
    if (rightmost < 0) {
      None
    } else {
      val ret = a(0)
      swap(0, rightmost)
      rightmost = rightmost - 1
      fixHeap
      Some(ret)
    }
  }

  private def indexOfMax(xs: IndexedSeq[Int]): Int = {
    var i = xs(0)
    var m = a(i)
    xs.foreach { x =>
      if (ord.gt(a(x), m)) {
        i = x
        m = a(i)
      }
    }
    i
  }

  private def fixHeap: Unit = {
    var p = 0
    var done = false
    while (!done) {
      val ks = children(p)
      if (ks.forall(k => ord.gteq(a(p), a(k)))) {
        done = true
      } else {
        val m = indexOfMax(ks)
        swap(p, m)
        p = m
      }
    }
  }

  require(n > 0, "arity must be greater than 0")

  (0 until a.size).foreach { i =>
    var j = i
    while (j != 0) {
      val p = parent(j)
      if (ord.lt(a(p), a(j))) {
        swap(p, j)
        j = p
      } else {
        j = 0
      }
    }
  }
}
