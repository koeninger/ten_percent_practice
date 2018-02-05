package belshaw.essential_scala.ch2

object Calc {
  def square(n: Double): Double = n * n
  def cube(n: Double): Double = n * square(n)
}

object Calc2 {
  def square(n: Double): Double = n * n
  def cube(n: Double): Double = n * square(n)
  def square(n: Int): Int = n * n
  def cube(n: Int): Int = n * square(n)
}

object Person { 
  val firstName = "Jarod"
  val lastName = "Belshaw"
}

object Alien {
  def greet(p: Person.type): String = {
    s"hello ${p.firstName} ${p.lastName}"
  }
}
