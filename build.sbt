import sbt.Keys.libraryDependencies

lazy val commonSettings = Seq(
  organization := "com.comparethemarket",
  scalaVersion := "2.12.6",
  test in assembly := {},
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
  fork := true,
  parallelExecution in Test := false
)

lazy val root = Project("db_patcher", file("."))
  .settings(commonSettings)
  .settings(
    resolvers += "aws-redshift" at "https://s3.amazonaws.com/redshift-maven-repository/release"
  )
  .settings(
    assemblyJarName in assembly := "db_patcher.jar"
  )
  .settings(
    libraryDependencies += "org.scalatest" %% "scalatest" % "3.0.5" % Test,
    libraryDependencies += "com.typesafe" % "config" % "1.3.2",
    libraryDependencies += "com.typesafe.scala-logging" %% "scala-logging" % "3.9.0",
    libraryDependencies += "com.iheart" %% "ficus" % "1.4.3",
    libraryDependencies += "org.scalikejdbc" %% "scalikejdbc" % "3.3.1",
    libraryDependencies += "ch.qos.logback" % "logback-classic" % "1.2.3",
    libraryDependencies += "org.postgresql" % "postgresql" % "42.2.4",
    libraryDependencies += "com.amazon.redshift" % "redshift-jdbc42" % "1.2.18.1036",
    libraryDependencies += "com.github.scopt" %% "scopt" % "3.7.0")

