package sandbox.ch10

import cats.Semigroup
import cats.data.Validated
import cats.data.Validated.{ Invalid, Valid }

sealed trait Check[E, A, B] {
  import Check._

  def apply(a: A): Validated[E, B]

  def map[C](func: B => C): Check[E, A, C] = Map(this, func)

  def flatMap[C](func: B => Check[E, A, C]): Check[E, A, C] = FlatMap(this, func)

  def andThen[C](that: Check[E, B, C]): Check[E, A, C] = AndThen(this, that)
}


object Check {
  final case class Pure[E, A](p: Predicate[E, A])(implicit s: Semigroup[E]) extends Check[E, A, A] {
    def apply(a: A): Validated[E, A] = p(a)
  }

  final case class Map[E, A, B, C](check: Check[E, A, B], func: B => C) extends Check[E, A, C] {
    def apply(a: A): Validated[E, C] = check(a).map(func)
  }

  final case class FlatMap[E, A, B, C](check: Check[E, A, B], func: B => Check[E, A, C]) extends Check[E, A, C] {
    def apply(a: A): Validated[E, C] = {
      check(a) match {
        case Invalid(e) => Invalid(e)
        case Valid(b) => func(b)(a)
      }
    }
  }

  final case class AndThen[E, A, B, C](check1: Check[E, A, B], check2: Check[E, B, C]) extends Check[E, A, C] {
    def apply(a: A): Validated[E, C] = {
      check1(a) match {
        case Invalid(e) => Invalid(e)
        case Valid(b) => check2(b)
      }
    }
  }

}
