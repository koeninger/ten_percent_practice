package algo.ch4

import org.scalatest.FunSuite

class TriangularUpperLeftArrayTest extends FunSuite {
  test("creation") {
    val a = new TriangularUpperLeftArray[Int](2)
    a(0, 0) = 0
    a(1, 0) = 1
    a(0, 1) = 2
    assert(a.toDebugString ===
      """|01
         |2_
         |""".stripMargin)

    assert(a(0, 1) === 2)

    val b = new TriangularUpperLeftArray[Int](1)
    b(0, 0) = 0
    assert(b.toDebugString === "0\n")
    assert(b(0, 0) === 0)

    val c = new TriangularUpperLeftArray[Int](3)
    c(0, 0) = 0
    c(1, 0) = 1
    c(2, 0) = 2
    c(0, 1) = 3
    c(1, 1) = 4
    c(0, 2) = 5
    assert(c.toDebugString ===
      """|012
         |34_
         |5__
         |""".stripMargin)
  }
}
