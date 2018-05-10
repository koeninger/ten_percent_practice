name := "print-tweets"
organization := "com.hyfnlocal"
version := "0.0.1"

scalaVersion := "2.11.8"

libraryDependencies ++= Seq(
  "org.apache.logging.log4j" % "log4j-scala" % "11.0",
  "org.apache.spark" %% "spark-core" % "2.2.0" % "provided",
  "org.apache.spark" %% "spark-streaming" % "2.2.0" % "provided",
  "org.apache.bahir" %% "spark-streaming-twitter" % "2.2.0" % "provided",
  "org.twitter4j" % "twitter4j-core" % "3.0.3",
  "org.twitter4j" % "twitter4j-stream" % "3.0.3"
)
