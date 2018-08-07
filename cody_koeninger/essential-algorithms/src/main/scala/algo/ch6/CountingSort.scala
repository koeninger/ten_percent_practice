package algo.ch6

object CountingSort {

  /* destructively sort a, assuming values range from min to max inclusive */
  def sort(a: Array[Int], min: Int, max: Int): Unit = {
    val range = 1 + max - min
    val count = new Array[Int](range)
    a.foreach { v =>
      val i = v - min
      count(i) = count(i) + 1
    }
    var i = 0
    (0 until range).foreach { v =>
      (0 until count(v)).foreach { _ =>
        a(i) = min + v
        i = i + 1
      }
    }
  }

  def sort(a: Array[Int]): Unit = {
    sort(a, a.min, a.max)
  }
}
