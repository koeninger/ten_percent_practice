package algo.ch4

import scala.util.Sorting

object Ex {
  def mean[T](a: Array[T])(implicit f: Fractional[T], n: Numeric[T]): T = {
    f.div(a.sum, n.fromInt(a.size))
  }

  def variance[T](a: Array[T])(implicit f: Fractional[T], n: Numeric[T]): T = {
    val m = mean(a)
    val s = a.map { x =>
      val d = n.minus(x, m)
      n.times(d, d)
    }.sum
    f.div(s, n.fromInt(a.size))
  }

  def stdDev[T](a: Array[T])(implicit f: Fractional[T], n: Numeric[T]): Double = {
    math.sqrt(f.toDouble(variance(a)))
  }

  /* destructively sorts a */
  def median[T](a: Array[T])(implicit f: Fractional[T], n: Numeric[T], o: math.Ordering[T]): T = {
    Sorting.quickSort(a)
    val mid = a.size / 2.0
    val flr = math.floor(mid)
    if (mid == flr) {
      f.div(n.plus(a(mid.toInt), a(mid.toInt - 1)), n.fromInt(2))
    } else {
      a(flr.toInt)
    }
  }

  def remove[T >: Null](a: Array[T], i: Int): Unit = {
    var j = i
    val stop = a.size - 1
    while (j < stop) {
      val n = j + 1
      a(j) = a(n)
      j = n
    }
    // can't resize an array in jvm, set last entry to null
    a(j) = null
  }
}
