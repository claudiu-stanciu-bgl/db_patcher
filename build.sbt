import Dependencies._

lazy val commonSettings = Seq(
  organization := "com.ctm",
  scalaVersion := "2.12.6",
  scalacOptions ++= Seq(
    "-target:jvm-1.8",
    "-encoding", "UTF-8",
    "-unchecked",
    "-deprecation",
    "-feature",
    "-Xfuture",
    "-Xlint",
    "-Yno-adapted-args",
    "-Ywarn-dead-code",
    "-Ywarn-numeric-widen",
    "-Ywarn-value-discard",
    "-Ywarn-unused",
    "-language:reflectiveCalls",
    "-language:implicitConversions"
  ),
  fork in Test := true,
  parallelExecution in Test := false
)

lazy val root = Project("sql_loader", file("."))
  .settings(commonSettings)
  .settings(
    libraryDependencies += scalaTest % Test
  )
