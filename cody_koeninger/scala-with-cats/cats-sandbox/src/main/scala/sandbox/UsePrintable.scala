package sandbox

object UsePrintable {
  final case class Cat(name: String, age: Int, color: String)

  implicit val printableCat = new Printable[Cat] {
    def format(a: Cat): String = s"${a.name} is a ${a.age} year-old ${a.color} cat."
  }

  def main(args: Array[String]): Unit = {
    val cat = Cat("garfield", 23, "orange")

    Printable.print(cat)
  }
}
