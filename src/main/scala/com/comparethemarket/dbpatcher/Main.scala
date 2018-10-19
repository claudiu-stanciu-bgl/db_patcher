package com.comparethemarket.dbpatcher

import java.io.File
import scala.util.{Failure, Success, Try}

import com.comparethemarket.dbpatcher.config.{CliConfig, DatabaseConfig, DbPatchesHelper}
import com.typesafe.config.ConfigFactory
import com.typesafe.scalalogging.StrictLogging
import net.ceedubs.ficus.Ficus._
import net.ceedubs.ficus.readers.ArbitraryTypeReader._
import scalikejdbc._

object Main extends App with StrictLogging {
  Try {
    val parser = new scopt.OptionParser[CliConfig]("db_patcher") {
      head("scopt", "3.x")
      opt[Int]("fromPatchIndex").valueName("0").action((x, c) =>
        c.copy(fromPatchIndex = x)).text("set from which patch index to run")
      opt[Map[String, String]]("passwords").valueName("db1=pass1,db2=pass2...").action((x, c) =>
        c.copy(passwords = x)).text("set database password")
    }

    val config = {
      val default = ConfigFactory.load()
      val merged = Option(System.getProperty("app.config")) map { configFile =>
        logger.info(s"Using config from file $configFile")
        ConfigFactory.parseFile(new File(configFile)).withFallback(default)
      } getOrElse default

      merged.resolve()
    }

    val dbConfig = config.as[DatabaseConfig]("app.db")
    val dbConfigDict = collection.mutable.Map[String, DatabaseConfig]()
    dbConfigDict(dbConfig.name) = dbConfig
    var fromPatchIndex = 0
    parser.parse(args, CliConfig()) match {
      case Some(cliConfig) =>
        cliConfig.passwords.foreach {
          case (db, pass) => {
            dbConfigDict(db).password = pass
          }
        }
        fromPatchIndex = cliConfig.fromPatchIndex
      case None => logger.info("No CLI parameters")
    }

    val dbPatchesDir = new File(config.as[String]("app.patches-dir"))

    val dbPatches = DbPatchesHelper(dbPatchesDir)

    val driverName = config.as[String]("app.driver-name")
    Class.forName(driverName)

    ConnectionPool.add(dbConfig.name, dbConfig.url, dbConfig.user, dbConfig.password)

    DbPatcher.patch(dbConfig, dbPatches, fromPatchIndex)

  } match {
    case Success(_) =>
      logger.info("Patching finished successfully")
    case Failure(ex) =>
      logger.error("Patching finished with errors. Exception " + ex.getMessage)
      sys.exit(1)
  }
}
