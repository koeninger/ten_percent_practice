Learning Spark by Karau, Konwinkski, Wendell, Zaharia from O'Reilly

Chapter 2 demo:

Download spark and extract to `learning-spark/spark-2.2.0-bin-hadoop2.7` rename `spark-2.2.0-bin-hadoop2.7` to `spark`
~~~~
  cd readlog
  sbt package
  .././spark/bin/spark-submit --class "readlog" --master local[4] target/scala-2.10/log-reader_2.10-0.0.1.jar
~~~~
