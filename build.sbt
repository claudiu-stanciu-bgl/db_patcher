import sbt.Keys.libraryDependencies

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
  fork in test := true,
  fork in run := true,
  parallelExecution in Test := false
)

lazy val root = Project("sql_loader", file("."))
  .settings(commonSettings)
  .settings(
    libraryDependencies += "org.scalatest" %% "scalatest" % "3.0.5" % Test,
    libraryDependencies += "com.typesafe" % "config" % "1.3.2",
    libraryDependencies += "com.typesafe.akka" %% "akka-actor" % "2.5.14",
    libraryDependencies += "com.typesafe.akka" %% "akka-testkit" % "2.5.14" % Test,
    libraryDependencies += "org.scalikejdbc" %% "scalikejdbc" % "3.3.+",
    libraryDependencies += "ch.qos.logback" % "logback-classic" % "1.2.3",
    libraryDependencies += "com.typesafe.scala-logging" %% "scala-logging" % "3.9.0",
    libraryDependencies += "org.postgresql" % "postgresql" % "42.2.4"
  )
