package sandbox.ch11

final case class GCounter(counters: Map[String, Int]) {
  def increment(machine: String, amount: Int): GCounter =
    GCounter(counters + (machine -> (counters.getOrElse(machine, 0) + amount)))

  def merge(that: GCounter): GCounter =
    GCounter(counters ++ that.counters.filter {
      case (k, v) => v > counters.getOrElse(k, 0)
    })

  def total: Int = counters.values.sum
}
