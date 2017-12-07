package sandbox.ch2

trait Semigroup[A] {
  def combine(x: A, y: A): A
}

trait Monoid[A] extends Semigroup[A] {
  def empty: A
}

object Monoid {
  def apply[A](implicit monoid: Monoid[A]) = monoid

  def fold[A](as: Seq[A])(implicit ev: Monoid[A]): A =
    as.foldLeft(ev.empty)(ev.combine)

  val integerAdd = new Monoid[Int] {
    def empty: Int = 0
    def combine(x: Int, y: Int): Int = x + y
  }

  val integerMultiply = new Monoid[Int] {
    def empty: Int = 1
    def combine(x: Int, y: Int): Int = x * y
  }

  val doubleAdd = new Monoid[Double] {
    def empty: Double = 0
    def combine(x: Double, y: Double): Double = x + y
  }

  val doubleMultiply = new Monoid[Double] {
    def empty: Double = 1
    def combine(x: Double, y: Double): Double = x * y
  }

  implicit def optionMonoid[A](implicit ev: Monoid[A]) = new Monoid[Option[A]] {
    def empty: Option[A] = None
    def combine(x: Option[A], y: Option[A]): Option[A] = (x, y) match {
      case (None, z) => z
      case (z, None) => z
      case (Some(xx), Some(yy)) => Some(ev.combine(xx, yy))
    }
  }

  val booleanAnd = new Monoid[Boolean] {
    def empty: Boolean = true
    def combine(x: Boolean, y: Boolean): Boolean = x && y
  }

  val booleanOr = new Monoid[Boolean] {
    def empty: Boolean = false
    def combine(x: Boolean, y: Boolean): Boolean = x || y
  }

  // this is a really bad idea
  class AllSet[A] extends Set[A] {
    override def contains(a: A): Boolean = true
    def iterator: Iterator[A] = Iterator.empty
    def -(elem: A): Set[A] = this
    def +(elem: A): Set[A] = Set(elem)
    override def intersect(as: scala.collection.GenSet[A]): Set[A] = as.iterator.toSet
    override def union(as: scala.collection.GenSet[A]): Set[A] = this
  }

  def setIntersect[A] = new Monoid[Set[A]] {
    def empty: Set[A] = new AllSet[A]()
    def combine(x: Set[A], y: Set[A]): Set[A] = x.intersect(y)
  }

  def setUnion[A] = new Monoid[Set[A]] {
    def empty: Set[A] = Set()
    def combine(x: Set[A], y: Set[A]): Set[A] = x.union(y)
  }
}

