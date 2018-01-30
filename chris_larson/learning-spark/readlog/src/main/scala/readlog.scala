import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

object readlog {
    def main(args: Array[String]) {
      val conf = new SparkConf().setMaster("local").setAppName("Log Reader")
      val sc = new SparkContext(conf)
      val date = "2017-10-19"
      val hour = "12"

      val textFile = sc.textFile("s3n://log-location."+date+"-"+hour+".*.gz")
      val count = sc.accumulator(0)
      val sum = sc.accumulator(0.0)
      val phpHackers = textFile.filter(line => line.contains(".php"))
      val num = phpHackers.count()
      println(s"Number of PHP hack attempts found: $num")
      phpHackers.take(10).foreach(println)

      val labels = textFile.filter(line => line.contains("#Fields:")).flatMap(line => line.replace("#Fields: ", "").split(" ")).collect.toList
      val timeIndex = labels.indexOf("time-taken")
      val urlIndex = labels.indexOf("cs-uri-stem")
      labels.foreach(line => println(line))
      println(s"Index of time-taken: $timeIndex")

      // Requests grouped by URL
      val pairRDD = textFile.filter(line => line.contains("http")).map(x => {
        (x.split("	")(urlIndex),x.split("	")(timeIndex).toDouble)
      })
      val tmp = pairRDD.values.foreach(y => {
        count += 1
        sum += y
      })
      val cnt = pairRDD.count()
      val cntKey = pairRDD.countByKey()
      val total = pairRDD.values.reduce((x,y) => x+y)
      val avg = total / cnt
      println(s"Accumulator Count: $count \n Sum: $sum \n")
      println(s"Count: $cnt \n Total: $total \n Average: $avg")
      cntKey.take(10).foreach(line => println("Pair by key "+line+" "))
      pairRDD.values.take(10).foreach(line => println("Loading in "+line+" seconds"))

      val test = textFile.filter(line => line.contains("http")).map(line => line.split("	")).map(line => line(timeIndex))
      test.take(10).foreach(line => println("Loading in "+line+" seconds"))
    }
}