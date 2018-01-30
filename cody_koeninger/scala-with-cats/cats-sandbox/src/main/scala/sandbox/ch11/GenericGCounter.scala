package sandbox.ch11

import cats.Monoid

final case class GenericGCounter[A](counters: Map[String, A]) {
  def increment(machine: String, amount: A)(implicit m: Monoid[A]): GenericGCounter[A] = {
    val c = m.combine(counters.getOrElse(machine, m.empty), amount)
    GenericGCounter(counters + (machine -> c))
  }

  def merge(that: GenericGCounter[A])(implicit b: BoundedSemiLattice[A]): GenericGCounter[A] =
    GenericGCounter(counters ++ that.counters.map {
      case (k, v) => k -> b.combine(v, counters.getOrElse(k, b.empty))
    })

  def total(implicit m: Monoid[A]): A = Monoid.combineAll(counters.values)
}
