import scala.xml.XML

val key = io.Source.fromFile("../../../openweathermap.txt").getLines.toList
val url ="http://api.openweathermap.org/data/2.5/forecast?mode=xml&lat=55&lon=0&appid=" + key(0)
val l = XML.load(url)
val location = l \\ "weatherdata" \ "location"
