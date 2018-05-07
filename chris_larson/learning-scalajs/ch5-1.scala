def double(x: Int): Int = x * 2
double(5)

val myDouble: (Int) => Int = double
myDouble(5)

val myDoubleCopy = myDouble
myDoubleCopy(5)

def double(x: Int): Int = x * 2
val myDouble = double _
val amount = myDouble(20)

def max(a: Int, b: Int) = if(a > b) a else b
val maximize: (Int, Int) => Int = max

maximize(50, 30)

def logStart() = "=" * 50 + "\nStarting NOW\n" + "=" * 50
val start: () => String = logStart
println( start())

def safeStringOp(s: String, f: String => String) = {
  if (s != null) f(s) else s
}
def reverser(s: String) = s.reverse
safeStringOp(null, reverser)
safeStringOp("Ready", reverser)

val doubler = (x: Int) => x * 2
val doubled = doubler(22)

val greeter = (name: String) => s"Hello, $name"
val hi = greeter("World")

val maximize = (a: Int, b: Int) => if (a > b) a else b
maximize(84, 96)

def start = () => "=" * 50 + "\nStarting NOW\n" + "=" * 50
println(start())

safeStringOp("Ready", (s: String) => s.reverse)
safeStringOp(null, s => s.reverse)
safeStringOp("Ready", s => s.reverse)

val doublr: Int => Int = _ * 2
def safeStringOp(s: String, f: String => String) = {
  if (s != null) f(s) else s
}
safeStringOp(null, _.reverse)
safeStringOp("Ready", _.reverse)

def combination(x: Int, y: Int, f: (Int,Int) => Int) = f(x,y)
combination(23, 12, _*_)
def tripleOp(a: Int, b: Int, c: Int, f: (Int, Int, Int) => Int) = f(a,b,c)
tripleOp(23, 92, 14, _*_+_)

def tripleOp[A, B](a: A, b: A, c: A, f: (A, A, A) => B) = f(a,b,c)
tripleOp[Int,Int](23, 92, 14, _*_+_)
tripleOp[Int, Double](23,92,14, 1.0*_/_/_)
tripleOp[Int,Boolean](93,92,14, _>_+_)

def factorOf(x: Int, y: Int) = y % x == 0
val f = factorOf _
val x = f(7, 20)

val multipleOf3 = factorOf(3, _: Int)
val y = multipleOf3(78)

def factorOf(x: Int)(y: Int) = y % x == 0
val isEven = factorOf(2) _
val z = isEven(32)

def doubles(x: => Int) = {
  println("Now doubling " + x)
  x * 2
}
doubles(5)

def f(i: Int) = { println(s"Hello from f($i)"); i }
doubles ( f(8) )

val statusHandler: Int => String = {
  case 200 => "Okay"
  case 400 => "Your Error"
  case 500 => "Our Error"
}
statusHandler(200)
statusHandler(400)
//statusHandler(401)

def safeStringOp(s: String, f: String => String) = {
  if (s != null) f(s) else s
}
val uuid = java.util.UUID.randomUUID.toString
val timedUUID = safeStringOp(uuid, { s =>
  val now = System.currentTimeMillis
  val timed = s.take(24) + now
  timed.toUpperCase
})

def safeStringOp(s: String)(f: String => String) = {
  if (s != null) f(s) else s
}

val timedUUID = safeStringOp(uuid) { s =>
  val now = System.currentTimeMillis
  val timed = s.take(24) + now
  timed.toUpperCase
}

def timer[A](f: => A): A = {
  def now = System.currentTimeMillis
  val start = now; val a = f; val end = now
  println(s"Executed in ${end - start} ms")
  a
}

val veryRandomAmount = timer {
  util.Random.setSeed(System.currentTimeMillis)
  for (i <- 1 to 100000) util.Random.nextDouble
  util.Random.nextDouble
}
