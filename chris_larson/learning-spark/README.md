Learning Spark by Karau, Konwinkski, Wendell, Zaharia from O'Reilly

Chapter 2 demo:
~~~~
  cd readlog
  sbt package
  .././spark/bin/spark-submit --class "readlog" --master local[4] target/scala-2.10/log-reader_2.10-0.0.1.jar
~~~~
