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

class Base { var i = 10 }
class Sub extends Base

def increment[B <: Base](b: Base) = { 
  b.i += 1
  b  
}

val l: List[Base] = List[Sub]()
val x: (Int, Int) = Tuple2(10, 20)
println("Does the arity = 2? " + (x.productArity == 2))

val hello1 = (n: String) => s"Hello, $n"
val h1 = hello1("Function Literals")
val hello2 = new Function1[String,String] {
  def apply(n: String) = s"Hello, $n"
}

val h2 = hello2("Function Instances")
println(s"hello1 = $hello1, hello2 = $hello2")

val doubler = (i: Int) => i*2
val plus3 = (i: Int) => i+3
val prepend = (doubler compose plus3)(1)
val append = (doubler andThen plus3)(1)
