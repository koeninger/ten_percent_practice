import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf

object readlog {
    def main(args: Array[String]) {
      val conf = new SparkConf().setMaster("local").setAppName("Log Reader")
      val sc = new SparkContext(conf)

      val textFile = sc.textFile("../E1IN64R500NXTW.2017-10-19-12.9c2ba7f3.txt")
      val cacheMiss = textFile.filter(line => line.contains("Miss"))
      val cacheHit = textFile.filter(line => line.contains("Hit"))
      val errors = textFile.filter(line => line.contains("Error"))
      val cacheMissAndErrors = cacheMiss.intersection(errors)
      cacheMissAndErrors.take(10).foreach(println)
    }
}