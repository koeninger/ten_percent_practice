package algo.ch5

import org.scalatest.FunSuite

class DequeTest extends FunSuite {
  test("empty") {
    val d = new Deque[Int]
    assert(d.toString == "()")
    assert(d.peekTop == None)
    assert(d.peekBottom == None)
    assert(d.popTop == None)
    assert(d.popBottom == None)
  }

  test("removal") {
    val d = new Deque[Int]
    d.pushTop(1)
    d.pushTop(2)
    assert(d.popBottom === Some(1))
    assert(d.popBottom === Some(2))
    assert(d.popBottom === None)
    d.pushBottom(1)
    d.pushBottom(2)
    assert(d.popTop === Some(1))
    assert(d.popTop === Some(2))
    assert(d.popTop === None)
    d.pushTop(1)
    d.pushTop(2)
    assert(d.popTop === Some(2))
    d.pushBottom(3)
    assert(d.popBottom === Some(3))
  }
}
