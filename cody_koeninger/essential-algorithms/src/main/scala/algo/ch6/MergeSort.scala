package algo.ch6

import scala.math.Ordering
import scala.reflect.ClassTag

object MergeSort {
  def sort[T](a: Array[T])(implicit ord: Ordering[T], ct: ClassTag[T]): Unit = {
    sort(a, new Array[T](a.size), 0, a.size - 1)
  }

  def sort[T](a: Array[T], scratch: Array[T], left: Int, right: Int)(implicit ord: Ordering[T]): Unit = {
    if (left == right) {
      // done
    } else {
      val mid = (left + right) / 2
      sort(a, scratch, left, mid)
      sort(a, scratch, mid + 1, right)
      var s = left
      var i = left
      var j = mid + 1
      while (i <= mid && j <= right) {
        if (ord.lteq(a(i), a(j))) {
          scratch(s) = a(i)
          i += 1
        } else {
          scratch(s) = a(j)
          j += 1
        }
        s += 1
      }
      while (i <= mid) {
        scratch(s) = a(i)
        i += 1
        s += 1
      }
      while (j <= right) {
        scratch(s) = a(j)
        j += 1
        s += 1
      }
      var x = left
      while (x <= right) {
        a(x) = scratch(x)
        x += 1
      }
    }
  }
}
