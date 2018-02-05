package sandbox.ch11

import cats.instances.int._
import org.scalatest.FunSuite


class TestGCounter extends FunSuite {
  val g1 = Map("a" -> 7, "b" -> 3)
  val g2 = Map("a" -> 2, "b" -> 5)
  val counter = TypeclassGCounter[Map, String, Int]

  test("typeclass gcounter") {
    val merged = counter.merge(g1, g2)
    assert(merged == Map("a" -> 7, "b" -> 5))
    val total = counter.total(merged)
    assert(total == 12)
  }
}

