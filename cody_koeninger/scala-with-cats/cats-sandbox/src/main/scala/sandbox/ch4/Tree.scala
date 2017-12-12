package sandbox.ch4

import cats.Monad

sealed trait Tree[+A]

final case class Branch[A](left: Tree[A], right: Tree[A]) extends Tree[A]
final case class Leaf[A](value: A) extends Tree[A]

object Tree {
  def branch[A](left: Tree[A], right: Tree[A]): Tree[A] = Branch(left, right)
  def leaf[A](value: A): Tree[A] = Leaf(value)

  implicit val treeMonad = new Monad[Tree] {
    def flatMap[A, B](ta: Tree[A])(fn: A => Tree[B]): Tree[B] = {
      ta match {
        case Leaf(a) => fn(a)
        case Branch(l, r) => branch(flatMap(l)(fn), flatMap(r)(fn))
      }
    }
    def pure[A](a: A): Tree[A] = leaf(a)
    // not actually tail recursive
    def tailRecM[A, B](a: A)(fn: A => Tree[Either[A, B]]): Tree[B] = {
      fn(a) match {
        case Leaf(Right(eb)) => pure(eb)
        case Leaf(Left(ea)) => tailRecM(ea)(fn)
        case Branch(l, r) => branch(
          flatMap(l)(e => e match {
            case Right(eb) => pure(eb)
            case Left(ea) => tailRecM(ea)(fn)
          }),
          flatMap(r)(e => e match {
            case Right(eb) => pure(eb)
            case Left(ea) => tailRecM(ea)(fn)
          }))
      }
    }
  }

}

