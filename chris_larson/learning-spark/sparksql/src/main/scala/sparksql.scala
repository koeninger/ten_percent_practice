import org.apache.spark.sql.SparkSession

object sparksql {
  def main(args: Array[String]) {
    val sc = SparkSession
      .builder()
      .appName("Spark SQL basic example")
      .config("spark.master", "local")
      .getOrCreate()

    import sc.implicits._

    val input = sc.read.json("../people.json")
    input.printSchema()
    input.show()
    println(s"done.")
  }
}