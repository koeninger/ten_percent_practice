object Hello { println("in Hello"); def hi = "hi" }
println(Hello.hi)
println(Hello.hi)

object HtmlUtils {
  def removeMarkup(input: String) = {
    input
    .replaceAll("""</?\w[^>]*>""","")
    .replaceAll("<.*>","")
  }
}

val html = "<html><body><h1>Introduction</h1></body></html>"
val text = HtmlUtils.removeMarkup(html)

// class Multiplier(val x: Int) { def product(y: Int) = x * y }
// object Multiplier { def apply(x: Int) = new Multiplier(x) }

//val tripler = Multiplier(3)
//val result = tripler.product(13)

// object DBConnection {
//   private val db_url = "jdbc://localhost"
//   private val db_user = "franken"
//   private val db_pass = "berry"
//   def apply() = new DBConnection
// }
// class DBConnection {
//   private val props = Map(
//     "url" -> DBConnection.db_url,
//     "user" -> DBConnection.db_user,
//     "pass" -> DBConnection.db_pass
//   )
//   println(s"Created new connection for " + props("url"))
// }

//val conn = DBConnection()

case class Character(name: String, isThief: Boolean)
val h = Character("Hadrian", true)
val r = h.copy(name = "Royce")
h == r
h match {
  case Character(x, true) => s"$x is a thief"
  case Character(x, false) => s"$x is not a thief"
}

trait HtmlUtils {
  def removeMarkup(input: String) = {
    input
    .replaceAll("""</?\w[^>]*>""","")
    .replaceAll("<.*>","")
  }
}

class Page(val s: String) extends HtmlUtils {
  def asPlainText = removeMarkup(s)
}
new Page("<html><body><h1>Introduction</h1></body></html>").asPlainText

trait SafeStringUtils {
  def trimToNone(s: String): Option[String] = {
    Option(s) map(_.trim) filterNot(_.isEmpty)
  }
}
class Page(val s: String) extends SafeStringUtils with HtmlUtils {
  def asPlainText: String = {
    trimToNone(s) map removeMarkup getOrElse "n/a"
  }
}

new Page("<html><body><h1>Introduction</h1></body></html>").asPlainText
new Page(" ").asPlainText
new Page(null).asPlainText

trait Base { override def toString = "Base" }
trait A extends Base { override def toString = "A->" + super.toString }
trait B extends Base { override def toString = "B->" + super.toString }
trait C extends Base { override def toString = "C->" + super.toString }
class D extends A with B with C { override def toString = "D->" + super.toString }
new D()

class RGBColor(val color: Int) { def hex = f"$color%06X" }
val green = new RGBColor(255 << 8).hex
trait Opaque extends RGBColor { override def hex = s"${super.hex}FF" }
trait Sheer extends RGBColor { override def hex = s"${super.hex}33" }
class Paint(color: Int) extends RGBColor(color) with Opaque
class Overlay(color: Int) extends RGBColor(color) with Sheer
val red = new Paint(128 << 16).hex
val blue = new Overlay(192).hex

class A { def hi = "hi" }
trait B { self: A =>
  override def toString = "B: " + hi
}
class C extends B
class C extends A with B 
new C()

class TestSuite(suiteName: String) { def start() {} }
trait RandomSeeded { self: TestSuite =>
  def randomStart() {
    util.Random.setSeed(System.currentTimeMillis)
    self.start()
  }  
}
class IdSpec extends TestSuite("ID Tests") with RandomSeeded {
  def testId() { println(util.Random.nextInt != 1) }
  override def start() { testId() }

  println("Starting...")
  randomStart()
}
