def areaCircle(radius: Double) = {
  2*radius*3.14
}
val area = areaCircle(4)

def stringArea(radius: String) = {
  var r = radius.toDouble
  2*r*3.14
}
val areaS = stringArea("4")

@annotation.tailrec
def printBy5(start: Int, stop: Int, t: Int = 0): Long = {
  if (t > stop) stop
  else {
    println(t)
    printBy5(start, stop, t+5)
    }

}
printBy5(5,50)

def milliToDate(milli: Long): String = {
  var year = (milli) / 31556926
  var month = (milli%31556926) / 2629743
  var day = (milli%31556926)%2629743 / 86400

  var hours = ((milli%31556926)%2629743)%86400 / 3600
  var minutes = (((milli%31556926)%2629743)%86400)%3600 / 60
  var seconds = (milli/1000)
  f"Years: $year, Months: $month, Day: $day, Hours: $hours, Minutes: $minutes"
}

val date = milliToDate(1524603346)