import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

object readlog {
    def main(args: Array[String]) {
      val conf = new SparkConf().setMaster("local").setAppName("Log Reader")
      val sc = new SparkContext(conf)

      val textFile = sc.textFile("../E1IN64R500NXTW.2017-10-19-12.9c2ba7f3.txt")
      val phpHackers = textFile.filter(line => line.contains(".php"))
      val num = phpHackers.count()
      println(s"Number of PHP hack attempts found: $num")
      phpHackers.take(10).foreach(println)

      val labels = textFile.filter(line => line.contains("#Fields:")).flatMap(line => line.replace("#Fields: ", "").split(" ")).collect.toList
      val timeIndex = labels.indexOf("time-taken")
      labels.foreach(line => println(line))
      println(s"Index of time-taken: $timeIndex")

      val pairRDD = textFile.filter(line => line.contains("http")).map(x => ("time-taken",x.split("	")(timeIndex).toDouble))
      val cnt = pairRDD.count()
      val total = pairRDD.values.reduce((x,y) => x+y)
      val avg = total / cnt
      println(s"Count: $cnt \n Total: $total \n Average: $avg")

      pairRDD.values.take(10).foreach(line => println("Loading in "+line+" seconds"))

      val test = textFile.filter(line => line.contains("http")).map(line => line.split("	")).map(line => line(timeIndex))
      test.take(10).foreach(line => println("Loading in "+line+" seconds"))
    }
}