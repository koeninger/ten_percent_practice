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

      val test = textFile.filter(line => line.contains("http")).map(line => line.split("	"))
      test.take(10).foreach(line => println("Loading in "+line(18)+" seconds"))
    }
}