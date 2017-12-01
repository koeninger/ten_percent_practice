package sandbox.ch1

trait Printable[A] {
  def format(a: A): String
}

object PrintableInstances {
  implicit val printableString = new Printable[String] {
    def format(a: String): String = a
  }

  implicit val printableInt = new Printable[Int] {
    def format(a: Int): String = a.toString
  }
}

object Printable {
  def format[A](a: A)(implicit ev: Printable[A]): String = ev.format(a)

  def print[A](a: A)(implicit ev: Printable[A]): Unit = println(format(a))
}

object PrintableSyntax {
  implicit class PrintableOps[A](a: A) {
    def format(implicit ev: Printable[A]): String = Printable.format(a)

    def print(implicit ev: Printable[A]): Unit = Printable.print(a)
  }
}
