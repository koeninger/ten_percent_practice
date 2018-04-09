def hi = "hi"
hi

def hi1: String = "hi"
def multiplier(x: Int, y: Int): Int = { x * y }
multiplier(6, 7)

def safeTrim(s: String): String = {
  if (s == null) return null
  s.trim()
}

def log(d: Double): Unit = println(f"Got value $d%.2f")

log(2.23535)

def hi(): String = "hi"
hi()
hi

def formatEuro(amt: Double) = f"E$amt%.2f"
formatEuro(3.4645)
formatEuro { val rate = 1.32; 0.235 + 0.7123 + rate * 5.32 }

@annotation.tailrec
def power(x: Int, n: Int, t: Int = 1): Long = {
  if (n < 1) t
  else power(x, n-1, x*t)
}
power(2, 8)
power(2,1)
power(2, 0)

def max(a: Int, b: Int, c: Int) = {
  def max(x: Int, y: Int) = if (x > y) x else y
  max(a, max(b, c))
}

max(42, 181, 19)

def greet(prefix: String, name: String) = s"$prefix $name"
val greeting1 = greet("Ms", "Brown")
val greeting2 = greet(name = "Brown", prefix = "Ms")

def greeting(prefix: String = "", name: String) = s"$prefix $name"
val greeting3 = greeting(name = "Paul")

def bettergreet(name: String, prefix: String = "") = s"$prefix $name"
val greeting4 = bettergreet("Ola")

def sum(items: Int*): Int = {
  var total = 0
  for (i <- items) total += i
  total
}

sum(10, 20, 30)
sum()
