package sandbox.ch2.cats

import cats.Monoid
import cats.syntax.semigroup._
import cats.instances.int._
import cats.instances.double._
import cats.instances.option._

object SuperAdderCats {
  case class Order(totalCost: Double, quantity: Double)
  object Order {
    implicit val orderMonoid = new Monoid[Order] {
      def empty: Order = Order(Monoid[Double].empty, Monoid[Double].empty)
      def combine(a: Order, b: Order) = Order(a.totalCost |+| b.totalCost, a.quantity |+| b.quantity)
    }
  }
  def fold[A](as: Seq[A])(implicit ev: Monoid[A]): A =
    as.foldLeft(ev.empty)(ev.combine)
  def add(items: List[Int]): Int = fold(items)
  def add(items: List[Option[Int]]): Option[Int] = fold(items)
  def add(items: List[Order]): Order = fold(items)

}
