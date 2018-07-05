package algo.ch3

import org.scalatest.FunSuite

class SingleLinkedListTest extends FunSuite {
  test("construction") {
    val s = new SingleLinkedList[Int]
    assert(s.toString === "()")
    assert(s.peekTop === None)
    s.addTop(1)
    assert(s.toString === "(1)")
    assert(s.peekTop === s.peekBottom)
    s.addBottom(2)
    assert(s.toString === "(1, 2)")
  }
  test("removal") {
    val s = new SingleLinkedList[Int]
    s.removeTop(0)
    assert(s.toString === "()")
    s.addTop(1)
    s.addTop(2)
    s.addTop(1)
    assert(s.toString === "(1, 2, 1)")
    s.removeTop(1)
    assert(s.toString === "(2, 1)")
    assert(s.peekTop === Some(2))
    assert(s.peekBottom === Some(1))
    s.addBottom(3)
    s.removeTop(1)
    assert(s.toString === "(2, 3)")
    s.removeTop(1)
    assert(s.toString === "(2, 3)")
  }
  test("largest") {
    val s = new SingleLinkedList[Int]
    assert(SingleLinkedList.largest(s) === None)
    s.addTop(1)
    s.addBottom(42)
    s.addBottom(23)
    assert(SingleLinkedList.largest(s) === Some(42))
  }
}
