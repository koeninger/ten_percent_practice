
val scalaTest = "org.scalatest" %% "scalatest" % "3.0.4" % "test"
val typesafeConfig = "com.typesafe" % "config" % "1.3.1"
val miniTest = "io.monix" %% "minitest" % "2.0.0" % "test"
val scalaCheck = "io.monix" %% "minitest-laws" % "2.0.0" % "test"

testFrameworks += new TestFramework("minitest.runner.Framework")

lazy val root = (project in file("."))
  .settings(
    name := "ten-percent-practice",
    organization := "belshaw",
    scalaVersion := "2.12.4",
    version := "0.1.0-SNAPSHOT",
    resolvers += "Artima Maven Repository" at "http://repo.artima.com/releases",
    libraryDependencies ++= Seq(
      typesafeConfig,
      miniTest,
      scalaCheck
    )
  )

