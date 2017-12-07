import org.apache.spark._
import org.apache.spark.SparkContext._
import org.apache.spark.sql.hive.HiveContext

object sparksql {
    def main(args: Array[String]) {
      val conf = new SparkConf().setMaster("local").setAppName("Spark SQL")
      val sc = new SparkContext(conf)
      val hiveCtx = new HiveContext(sc)
      val input = hiveCtx.jsonFile(./testtweets.json)
      input.registerTempTable("tweets")
      val topTweets = hiveCtx.sql("SELECT text, retweetCount FROM tweets ORDER BY retweetCount LIMIT 10")
      val topTweetText = topTweets.rdd().map(row => row.getString(0))
      println("top tweet: $topTweetText"
    }
}