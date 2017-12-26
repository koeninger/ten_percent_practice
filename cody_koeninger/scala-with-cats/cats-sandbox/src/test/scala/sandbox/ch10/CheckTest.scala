package sandbox.ch10

import cats.Semigroupal
import cats.data.NonEmptyList
import cats.data.Validated
import cats.data.Validated.{ Valid, Invalid }

import org.scalatest.FunSuite

class CheckTest extends FunSuite {
  type Errors = NonEmptyList[String]
  type AllErrors[A] = Validated[Errors, A]

  def error(s: String): NonEmptyList[String] = NonEmptyList(s, Nil)

  def longerThan(n: Int): Predicate[Errors, String] =
    Predicate.lift(
      error(s"Must be longer than $n characters"),
      s => s.size > n)

  def alphanumeric: Predicate[Errors, String] =
    Predicate.lift(
      error("Must all be alphanumeric characters"),
      s => s.forall(_.isLetterOrDigit))

  def contains(c: Char): Predicate[Errors, String] =
    Predicate.lift(
      error(s"Must contain the character $c"),
      s => s.contains(c))

  def containsOnce(c: Char): Predicate[Errors, String] =
    Predicate.lift(
      error(s"Must contain the character $c exactly once"),
      s => s.filter(_ == c).length == 1)

  def username: Predicate[Errors, String] =
    longerThan(3).and(alphanumeric)

  def email: Predicate[Errors, String] = Predicate.Pure { s =>
    s.split('@') match {
      case Array(left, right) =>
        Semigroupal[AllErrors].product(
          longerThan(0)(left),
          longerThan(2).and(contains('.'))(right)).
          map(_ => s)
      case _ =>
        Invalid(NonEmptyList("Must contain exactly one '@'", Nil))
    }
  }

  test("username") {
    assert(username("bob").isInstanceOf[Invalid[_]])
    assert(username("bobo").isInstanceOf[Valid[_]])
  }

  test("email") {
    assert(email("f@f").isInstanceOf[Invalid[_]])
    assert(email("f.com").isInstanceOf[Invalid[_]])
    assert(email("@f.com").isInstanceOf[Invalid[_]])
    assert(email("b@f.c").isInstanceOf[Valid[_]])
  }
}
