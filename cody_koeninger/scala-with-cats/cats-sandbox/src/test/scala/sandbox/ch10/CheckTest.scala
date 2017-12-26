package sandbox.ch10

import cats.data.Validated.{ Valid, Invalid }
import cats.instances.list._
import org.scalatest.FunSuite

class CheckTest extends FunSuite {
  type C = Check[List[String], Int]
  val err = Invalid(List("boom"))
  val ok: C = Check((x: Int) => Valid(x))
  val bad: C = Check((x: Int) => err)

  test("and") {
    assert(ok.and(bad).apply(1) == err)
    assert(bad.and(ok).apply(1) == err)
    assert(ok.and(ok).apply(1) == Valid(1))
    assert(ok.or(bad).apply(1) == Valid(1))
    assert(bad.or(ok).apply(1) == Valid(1))
    assert(bad.or(bad).apply(1) == err)
  }

  test("or") {
    assert(ok.or(ok).apply(1) == Valid(1))
    assert(ok.or(bad).apply(1) == Valid(1))
    assert(bad.or(ok).apply(1) == Valid(1))
    assert(bad.or(bad).apply(1) == err)
  }
}
