Learning Spark by Karau, Konwinkski, Wendell, Zaharia from O'Reilly

Download spark and extract to `learning-spark/spark-2.2.0-bin-hadoop2.7` rename `spark-2.2.0-bin-hadoop2.7` to `spark`

Read Log
~~~~
$ export AWS_ACCESS_KEY_ID=abcd
$ export AWS_SECRET_ACCESS_KEY=abcd
$ cd readlog
$ sbt package
$ .././spark/bin/spark-submit --class "readlog" --master local[4] target/scala-2.10/log-reader_2.10-0.0.1.jar
~~~~

Spark SQL
~~~~
sbt package
../spark/bin/spark-submit --class "sparksql" --master local[4] target/scala-2.11/spark-sql_2.11-0.0.1.jar
~~~~


Spark Streaming
~~~~
../spark/bin/spark-submit --class "com.hyfnlocal.sparkstreaming.printtweets" --packages org.apache.bahir:spark-streaming-twitter_2.11:2.2.0 --master local[4] target/scala-2.11/print-tweets_2.11-0.0.1.jar
~~~~