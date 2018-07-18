package algo.ch4

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
}
