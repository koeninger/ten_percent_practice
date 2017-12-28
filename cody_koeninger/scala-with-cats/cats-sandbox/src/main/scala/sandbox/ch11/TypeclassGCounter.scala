package sandbox.ch11

import cats.Monoid

trait TypeclassGCounter[F[_,_], K, V] {
  def increment(f: F[K, V])(k: K, v: V)(implicit m: Monoid[V]): F[K, V]

  def merge(f1: F[K, V], f2: F[K, V])(implicit b: BoundedSemiLattice[V]): F[K, V]

  def total(f: F[K, V])(implicit m: Monoid[V]): V
}

object TypeclassGCounter {
  def apply[F[_,_], K, V](implicit c: TypeclassGCounter[F, K, V]): TypeclassGCounter[F, K, V] = c

  implicit def mapGCounter[K, V]: TypeclassGCounter[Map, K, V] = new TypeclassGCounter[Map, K, V] {
    def increment(f: Map[K, V])(k: K, v: V)(implicit m: Monoid[V]): Map[K, V] = {
      val c = m.combine(f.getOrElse(k, m.empty), v)
      f + (k -> c)
    }

    def merge(f1: Map[K, V], f2: Map[K, V])(implicit b: BoundedSemiLattice[V]): Map[K, V] =
      f1 ++ f2.map {
        case (k, v) => k -> b.combine(v, f1.getOrElse(k, b.empty))
      }

    def total(f: Map[K, V])(implicit m: Monoid[V]): V =
      Monoid.combineAll(f.values)
  }
}
