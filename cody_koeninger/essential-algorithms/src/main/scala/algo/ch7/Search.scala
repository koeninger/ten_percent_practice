package algo.ch7

import scala.math.Ordering

object Search {
  /* assumes a is sorted in increasing order */
  def binary[T](a: Array[T], v: T)(implicit ord: Ordering[T]): Boolean = {
    var min = 0
    var max = a.size - 1
    var mid = (min + max) / 2

    while (min <= max) {
      if (a(mid) == v) {
        return true
      } else if (ord.gt(a(mid), v)) {
        max = mid
      } else {
        min = mid
      }
      mid = (min + max) / 2
    }
    false
  }

  def chooseMid(a: Array[Int], v: Int, min: Int, max: Int): Int = {
    val indexRange = max - min
    val valueRange = a(max).toLong - a(min)
    val percent = (v.toDouble - a(min)) / valueRange
    min + (percent * indexRange).toInt
  }

  /* assumes a is sorted in increasing order */
  def interpolation(a: Array[Int], v: Int): Boolean = {
    var min = 0
    var max = a.size - 1
    var mid = chooseMid(a, v, min, max)

    while (min <= max) {
      if (a(mid) == v) {
        return true
      } else if (a(mid) > v) {
        max = mid
      } else {
        min = mid
      }
      val newMid = chooseMid(a, v, min, max)
      if (mid == newMid) {
        mid = mid + 1
      } else {
        mid = newMid
      }
    }
    false
  }
}
