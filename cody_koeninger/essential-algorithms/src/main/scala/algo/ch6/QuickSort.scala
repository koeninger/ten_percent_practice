package algo.ch6

import scala.math.Ordering
import scala.util.Random

object QuickSort {
  def choosePivot(left: Int, right: Int): Int = {
    Random.nextInt(right - left) + left
  }

  /* destructive, in-place quicksort */
  def sort[T](a: Array[T])(implicit ord: Ordering[T]): Unit =
    sort(a, 0, a.size - 1)

  def sort[T](a: Array[T], left: Int, right: Int)(implicit ord: Ordering[T]): Unit = {
    if (left >= right) {
      // done
    } else {
      val p = choosePivot(left, right)
      val pv = a(p)
      var lo = left
      var hi = right
      // start with hole in the lowest / leftmost position
      a(p) = a(lo)

      while (lo < hi) {
        // search from hi to lo for next val less than pivot value
        while (ord.gteq(a(hi), pv) && lo < hi) {
          hi = hi - 1
        }
        // put it in the hole
        a(lo) = a(hi)

        // search from lo to high for next value greater than pivot value
        while (ord.lteq(a(lo), pv) && lo < hi) {
          lo = lo + 1
        }
        // put it in the hole
        a(hi) = a(lo)
      }
      assert(lo == hi)

      // put the pivot value back in the last remaining hole
      a(lo) = pv

      sort(a, left, lo)
      sort(a, lo + 1, right)
    }
  }
}
