import org.apache.spark.sql.SparkSession

object sparksql {
    def main(args: Array[String]) {
      val sc = SparkSession
        .builder()
        .appName("Spark SQL basic example")
        .master("local")
        .getOrCreate()

      import sc.implicits._

      val input = sc.read.json("../testtweets.json")
      println(s"done.")
    }
}