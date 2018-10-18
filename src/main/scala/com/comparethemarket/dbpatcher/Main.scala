package com.comparethemarket.dbpatcher

import java.io.File
import scala.util.{Failure, Success, Try}

import com.typesafe.config.ConfigFactory
import com.typesafe.scalalogging.StrictLogging
import net.ceedubs.ficus.Ficus._
import scalikejdbc._

object Main extends App with StrictLogging {
  Try {
    val config = {
      val default = ConfigFactory.load()
      val merged = Option(System.getProperty("app.config")) map { configFile =>
        logger.info(s"Using config from file $configFile")
        ConfigFactory.parseFile(new File(configFile)).withFallback(default)
      } getOrElse default

      merged.resolve()
    }

    val dbConfig = config.as[DatabaseConfig]("app.db")
    val dbPatchesDir = config.as[String]("app.patches-dir")

    val dbPatchFiles = new File(dbPatchesDir).listFiles().filter(_.isFile).filter(!_.toString.toLowerCase.contains("rollback"))
    val dbPatches = dbPatchFiles.map(DbPatch(_)).sorted

    Class.forName("org.postgresql.Driver")

    ConnectionPool.add(dbConfig.name, dbConfig.url, dbConfig.user, dbConfig.password)

    DbPatcher.patch(dbConfig, dbPatches)

  } match {
    case Success(_) =>
      logger.info("Patching initiated")
    case Failure(ex) =>
      logger.error("Exception " + ex.getMessage)
      sys.exit(1)
  }
}
