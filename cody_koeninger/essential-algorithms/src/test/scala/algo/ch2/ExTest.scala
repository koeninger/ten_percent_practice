package algo.ch2

import org.scalactic.TolerantNumerics
import org.scalatest.FunSuite

class ExTest extends FunSuite {
  import Ex._

  implicit val doubleEq = TolerantNumerics.tolerantDoubleEquality(1e-2f)

  test("fairFromBiased is fair") {
    val d = new BiasedDie(6)
    val unfair = (1 to 1000000).map(_ => d())
    assert(unfair.sum.toDouble / unfair.size !== 3.5)
    val fair = (1 to 1000000).map(_ => fairFromBiased(d))
    assert(fair.sum.toDouble / fair.size === 3.5)
  }
}
