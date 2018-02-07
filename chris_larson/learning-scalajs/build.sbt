enablePlugins(ScalaJSPlugin)

name := "Scala.js Tutorial"
scalaVersion := "2.12.2"

// This is an application with a main method
scalaJSUseMainModuleInitializer := true
libraryDependencies ++= Seq(
  "org.scala-js" %%% "scalajs-dom" % "0.9.1",
  "org.singlespaced" %%% "scalajs-d3" % "0.3.4"
)