package sandbox.ch2

import org.scalatest.FunSuite
import Monoid.fold

class MonoidTest extends FunSuite {
  test("boolean and") {
    implicit val bm = Monoid.booleanAnd
    assert(!fold(List(true, false, true)))
    assert(fold(List(true, true, true)))
  }
  test("boolean or") {
    implicit val bm = Monoid.booleanOr
    assert(fold(List(true, false, true)))
    assert(!fold(List(false, false, false)))
  }
  test("set intersection") {
    implicit val sm = Monoid.setIntersect[Int]
    assert(fold(List(Set(1,2,3), Set(2,3,4), Set(3,4,5))) === Set(3))
  }
  test("set union") {
    implicit val sm = Monoid.setUnion[Int]
    assert(fold(List(Set(1,2,3), Set(2,3,4), Set(3,4,5))) === Set(1,2,3,4,5))
  }
}
