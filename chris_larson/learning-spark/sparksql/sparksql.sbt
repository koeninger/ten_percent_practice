name := "spark-sql"

version := "0.0.1"

scalaVersion := "2.11.9"

libraryDependencies ++= Seq(
  "org.apache.spark" %% "spark-core" % "2.2.0" % "provided",
  "org.apache.spark" %% "spark-sql" % "2.2.0",
  "org.apache.spark" %% "spark-hive" % "2.2.0"
)
