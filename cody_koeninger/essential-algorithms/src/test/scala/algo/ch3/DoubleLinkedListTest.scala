package algo.ch3

import org.scalatest.FunSuite

class DoubleLinkedListTest extends FunSuite {
  test("construction") {
    val d = new DoubleLinkedList[Int]
    assert(d.toString === "()")
    d.addTop(1)
    assert(d.toString === "(1)")
    d.addBottom(2)
    assert(d.toString === "(1, 2)")
    d.addTop(0)
    assert(d.toString === "(0, 1, 2)")
  }
  test("removal") {
    val d = new DoubleLinkedList[Int]
    d.addTop(1)
    d.addTop(2)
    d.addTop(1)
    d.addTop(3)
    d.addTop(1)
    d.deleteAll(1)
    assert(d.toString === "(3, 2)")
  }

  test("sorting") {
    val d = new DoubleLinkedList[Int]
    d.addBottom(1)
    d.addBottom(2)
    d.addBottom(3)
    d.addBottom(4)
    assert(d.isSorted)
    d.addTop(5)
    assert(!d.isSorted)
  }
}
