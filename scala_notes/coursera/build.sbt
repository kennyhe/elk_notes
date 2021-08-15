import sbt.Keys.libraryDependencies

val scala3Version = "3.0.1"

lazy val root = project
  .in(file("."))
  .settings(
    name := "Coursera-Functional-Programming",
    version := "0.1.0",

    scalaVersion := scala3Version,

    libraryDependencies ++= Seq(
      "com.novocode" % "junit-interface" % "0.11" % "test",
      "org.scalameta" % "munit_3" % "0.7.26" % Test
    ),
  )
