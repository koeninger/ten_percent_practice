import scala.xml.XML

val key = io.Source.fromFile("../../../openweathermap.txt").getLines.toList
val url ="http://api.openweathermap.org/data/2.5/forecast?mode=xml&lat=55&lon=0&appid=" + key(0)
val l = XML.load(url)
def fahrenheit(x: String): Double = {
  (x.toDouble * 9 / 5) - 459.67
}
println()
val city = l \\ "weatherdata" \ "location" \ "name"
println()
val forecast0 = (l \\ "weatherdata" \ "forecast" \ "time")(0) \ "temperature" \ "@max"
fahrenheit(forecast0.toString)
println()
val forecast1 = (l \\ "weatherdata" \ "forecast" \ "time")(1) \ "temperature" \ "@max"
fahrenheit(forecast1.toString)