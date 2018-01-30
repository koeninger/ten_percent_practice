package sandbox.ch11

import cats.Monoid

trait BoundedSemiLattice[A] extends Monoid[A] {
  def combine(a1: A, a2: A): A

  def empty: A
}

object BoundedSemiLattice {
  implicit val intBoundedSemiLattice = new BoundedSemiLattice[Int] {
    def combine(a1: Int, a2: Int): Int = a1.max(a2)

    def empty: Int = 0
  }

  implicit def setBoundedSemiLattice[A] = new BoundedSemiLattice[Set[A]] {
    def combine(s1: Set[A], s2: Set[A]): Set[A] = s1.union(s2)

    def empty: Set[A] = Set()
  }
}
