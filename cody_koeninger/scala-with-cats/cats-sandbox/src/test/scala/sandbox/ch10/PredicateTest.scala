package sandbox.ch10

import cats.data.Validated.{ Valid, Invalid }
import cats.instances.list._
import org.scalatest.FunSuite

class PredicateTest extends FunSuite {
  type P = Predicate[List[String], Int]
  val err = Invalid(List("boom"))
  val bothErrs = Invalid(List("boom", "boom"))
  val ok: P = Predicate.Pure((x: Int) => Valid(x))
  val bad: P = Predicate.Pure((x: Int) => err)

  test("and") {
    assert(ok.and(bad).apply(1) == err)
    assert(bad.and(ok).apply(1) == err)
    assert(ok.and(ok).apply(1) == Valid(1))
    assert(bad.and(bad).apply(1) == bothErrs)
  }

  test("or") {
    assert(ok.or(ok).apply(1) == Valid(1))
    assert(ok.or(bad).apply(1) == Valid(1))
    assert(bad.or(ok).apply(1) == Valid(1))
    assert(bad.or(bad).apply(1) == bothErrs)
  }
}
