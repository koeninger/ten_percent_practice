import concurrent.ExecutionContext.Implicits.global
val f = concurrent.Future { println("hi") }

val f = concurrent.Future { Thread.sleep(500); println("hi") }
println("waiting")

import concurrent.ExecutionContext.Implicits.global
import concurrent.Future
def nextFtr(i: Int = 0) = Future {
  def rand(x: Int) = util.Random.nextInt(x)
  Thread.sleep(rand(5000))
  if (rand(3) > 0) (i + 1) else throw new Exception
}

nextFtr(1) fallbackTo nextFtr(2)
//nextFtr(1) flatMap nextFtr()
nextFtr(1) map (_ * 2)
nextFtr() onComplete { _ getOrElse 0 }
nextFtr() onFailure { case _ => "Error!" }
nextFtr() onSuccess { case x => s"Got $x" }
concurrent.Future sequence List(nextFtr(1), nextFtr(5))

import concurrent.Future
def cityTemp(name: String): Double = {
  val key = io.Source.fromFile("../../../openweathermap.txt").getLines.toList
  val url = "http://api.openweathermap.org/data/2.5/weather"
  val cityUrl = s"$url?q=$name&appid=" + key(0)
  println(cityUrl)
  val json = io.Source.fromURL(cityUrl).mkString.trim
  val pattern = """.*temp":([\d.]+).*""".r
  val pattern(temp) = json
  temp.toDouble
}
val cityTemps = Future sequence Seq(
  Future(cityTemp("Fresno")), Future(cityTemp("Tempe"))
)
cityTemps onSuccess {
  case Seq(x,y) if x > y => println(s"Fresno is warmer: $x K")
  case Seq(x,y) if y > x => println(s"Tempe is warmer: $y K")
}