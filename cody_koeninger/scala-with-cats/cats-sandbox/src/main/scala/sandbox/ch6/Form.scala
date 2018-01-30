package sandbox.ch6

import cats.Semigroupal
import cats.data.Validated
import cats.instances.list._
import cats.syntax.either._
import cats.syntax.apply._

import scala.util.Try

case class User(name: String, age: Int)

object Form {
  type Args = Map[String, String]
  type Errs = List[String]
  type ErrsV[A] = Validated[Errs, A]

  implicit val semigroupalErrs = Semigroupal[ErrsV]

  def user(args: Args): Validated[Errs, User] = {
    (readName(args).toValidated,
     readAge(args).toValidated
    ).mapN(User)
  }

  def readName(args: Args): Either[Errs, String] = {
    val f = "name"
    getValue(args, f).flatMap(v => nonBlank(f, v))
  }

  def readAge(args: Args): Either[Errs, Int] = {
    val f = "age"
    for {
      v <- getValue(args, f)
      i <- parseInt(f, v)
      n <- nonNegative(f, i)
    } yield {
      n
    }
  }

  def getValue(args: Args, field: String): Either[Errs, String] = {
    args.get(field).toRight(List(s"Unknown $field"))
  }

  def parseInt(field: String, str: String): Either[Errs, Int] = {
    Try { str.toInt }.toEither.left.map(x => List(s"Bad $field: $x"))
  }

  def nonBlank(field: String, value: String): Either[Errs, String] = {
    if (value == "") {
      Left(List(s"$field can't be blank"))
    } else {
      Right(value)
    }
  }

  def nonNegative(field: String, value: Int): Either[Errs, Int] = {
    if (value < 0) {
      Left(List(s"$field can't be negative"))
    } else {
      Right(value)
    }
  }
}
