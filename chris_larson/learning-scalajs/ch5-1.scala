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
