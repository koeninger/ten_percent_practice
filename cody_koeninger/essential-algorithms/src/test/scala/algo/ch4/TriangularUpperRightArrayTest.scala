package algo.ch4

import org.scalatest.FunSuite

class TriangularUpperRightArrayTest extends FunSuite {
  test("creation") {
    val a = new TriangularUpperRightArray[Int](2)
    a(0, 0) = 0
    a(1, 0) = 1
    a(1, 1) = 2
    assert(a.toDebugString ===
      """|01
         |_2
         |""".stripMargin)

    assert(a(1, 1) === 2)

    val b = new TriangularUpperRightArray[Int](1)
    b(0, 0) = 0
    assert(b.toDebugString === "0\n")
    assert(b(0, 0) === 0)

    val c = new TriangularUpperRightArray[Int](3)
    c(0, 0) = 0
    c(1, 0) = 1
    c(2, 0) = 2
    c(1, 1) = 3
    c(2, 1) = 4
    c(2, 2) = 5
    assert(c.toDebugString ===
      """|012
         |_34
         |__5
         |""".stripMargin)
  }
}
