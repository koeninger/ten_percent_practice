package sandbox.ch10

import cats.Semigroup
import cats.data.Validated
import Validated.{ Valid, Invalid }
import cats.syntax.semigroup._

trait Check[E, A] { self =>
  def apply(value: A): Validated[E, A]

  def and(that: Check[E, A])(implicit ev: Semigroup[E]): Check[E, A] = new Check[E, A] {
    def apply(value: A): Validated[E, A] = {
      (self(value), that(value)) match {
        case (Valid(a), Valid(_)) => Valid(a)
        case (Invalid(e), Invalid(e2)) => Invalid(e |+| e2)
        case (Invalid(e), _) => Invalid(e)
        case (_, Invalid(e)) => Invalid(e)
      }
    }
  }

  def or(that: Check[E, A]) = new Check[E, A] {
    def apply(value: A): Validated[E, A] = {
      self(value).orElse(that(value))
    }
  }
}

object Check {
  def apply[E, A](fn: A => Validated[E, A]): Check[E, A] = new Check[E, A] {
    def apply(a: A): Validated[E, A] = fn(a)
  }
}

