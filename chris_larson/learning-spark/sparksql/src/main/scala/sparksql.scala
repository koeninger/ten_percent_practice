import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.Row
import org.apache.spark.sql.types._

object sparksql {
  def main(args: Array[String]) {
    val sc = SparkSession
      .builder()
      .appName("Spark SQL basic example")
      .config("spark.master", "local")
      .getOrCreate()

    import sc.implicits._
    import sc.sql

    //val input = sc.read.csv("../E1IN64R500NXTW.2017-10-19-12.9c2ba7f3.txt")
    // #Fields: date time x-edge-location sc-bytes c-ip cs-method cs(Host) cs-uri-stem sc-status cs(Referer) cs(User-Agent) cs-uri-query cs(Cookie) x-edge-result-type x-edge-request-id x-host-header cs-protocol cs-bytes time-taken x-forwarded-for ssl-protocol ssl-cipher x-edge-response-result-type cs-protocol-version
    val schemaString = "date time x-edge-location sc-bytes c-ip cs-method cs(Host) cs-uri-stem sc-status cs(Referer) cs(User-Agent) cs-uri-query cs(Cookie) x-edge-result-type x-edge-request-id x-host-header cs-protocol cs-bytes time-taken x-forwarded-for ssl-protocol ssl-cipher x-edge-response-result-type cs-protocol-version"

    // Generate the schema based on the string of schema
    val fields = schemaString.split(" ")
      .map(fieldName => StructField(fieldName, StringType, nullable = true))
    val schema = StructType(fields)
    def row(line: List[String]): Row = { Row(line(0), line(1), line(2), line(3), line(4), line(5), line(6), line(7), line(8), line(9), line(10), line(11), line(12), line(13), line(14), line(15), line(16), line(17), line(18), line(19), line(20), line(21), line(22), line(23), line(24)) }

    val logfile = sc.sparkContext.textFile("../E1IN64R500NXTW.2017-10-19-12.9c2ba7f3.txt")

    //val rowRDD = logfile.map(_.split("	")).map(attributes => Row(attributes(0), attributes(1).trim))
    val rowRDD = logfile.filter(line => line.contains("http")).map(_.split("	").to[List]).map(row)
    
    rowRDD.take(10).foreach(println)

    val input = sc.createDataFrame(rowRDD, schema)

    println(s"printSchema()")
    input.printSchema()
    println(s"show()")
    input.show()
    println(s"done.")
  }
}