val t1: (Int, Char) = (1, 'a')
val t2: (Int, Char) = Tuple2[Int, Char](1, 'a')
val f1: Int=>Int = _ + 2
val f2: Int=>Int = new Function1[Int, Int] { def apply(x: Int) = x * 2 }

object ImplicitClasses {
  implicit class Hello(s: String) { def hello = s"Hello, $s" }
  def test = {
    println( "World".hello )
  }
}
ImplicitClasses.test

object ImplicitParams {
  def greet(name: String)(implicit greeting: String) = s"greeting, $name"
  implicit val hi = "Hello"
  def test = {
    println( greet("Developers") )
  }
}
ImplicitParams.test