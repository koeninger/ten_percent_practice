package sandbox.ch2

object SuperAdder {
  implicit val intMonoid = Monoid.integerAdd
  implicit val doubleMonoid = Monoid.doubleAdd
  def add(items: List[Int]): Int = Monoid.fold(items)
  def add(items: List[Option[Int]]): Option[Int] = Monoid.fold(items)(Monoid.optionMonoid[Int])

  case class Order(totalCost: Double, quantity: Double)
  object Order {
    implicit val orderMonoid = new Monoid[Order] {
      def empty: Order = Order(doubleMonoid.empty, doubleMonoid.empty)
      def combine(a: Order, b: Order) = Order(doubleMonoid.combine(a.totalCost, b.totalCost), doubleMonoid.combine(a.quantity, b.quantity))
    }
  }
  def add(items: List[Order]): Order = Monoid.fold(items)
}
