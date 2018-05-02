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
