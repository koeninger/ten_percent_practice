package algo.ch8

import org.scalatest.FunSuite

class HashTableTest extends FunSuite {
  val capacity = 100
  test("chaining") {
    val h = new ChainingHashTable[Int, String](capacity)
    assert(h(-1) === None)
    assert(h.size === 0)
    h(-1) = -1.toString
    assert(h(-1) === Some("-1"))
    assert(h.size === 1)
    h.delete(-1)
    assert(h.size === 0)
    assert(h(-1) === None)
  }
}
