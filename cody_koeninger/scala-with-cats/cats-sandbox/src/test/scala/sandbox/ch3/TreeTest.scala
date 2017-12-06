package sandbox.ch3

import org.scalatest.FunSuite
import cats.syntax.functor._

class TreeTest extends FunSuite {

  test("leaf") {
    val t: Tree[Int] = Leaf(1)
    assert(t.map(_ + 2) == Leaf(3))
  }
  test("branches") {
    val t: Tree[Int] = Branch(Leaf(1), Branch(Leaf(2), Leaf(3)))
    assert(t.map(_ + 1) == Branch(Leaf(2), Branch(Leaf(3), Leaf(4))))
  }
}
