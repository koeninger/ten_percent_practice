package algo.ch4

import org.scalatest.FunSuite

class ExTest extends FunSuite {
  test("median") {
    assert(Ex.median(Array(1.0, 2, 3)) === 2)
    assert(Ex.median(Array(1.0, 2, 3, 4)) === 2.5)
  }

  test("removal") {
    val a = Array("0", "1", "2", "3")
    Ex.remove(a, 3)
    assert(a === Array("0", "1", "2", null))
    Ex.remove(a, 0)
    assert(a === Array("1", "2", null, null))
  }
}
