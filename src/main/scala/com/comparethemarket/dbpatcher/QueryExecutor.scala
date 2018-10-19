package com.comparethemarket.dbpatcher

import scala.util.{Failure, Success, Try}

import com.comparethemarket.dbpatcher.config.DatabaseConfig
import com.typesafe.scalalogging.StrictLogging
import scalikejdbc.TxBoundary.Try._
import scalikejdbc.{ConnectionPool, DB, SQL, using}

object QueryExecutor extends StrictLogging {

  def runQuery(dbConfig: DatabaseConfig, sqlScript: String): Unit = {
    logger.debug(s"Executing sqlPatch")

    using(DB(ConnectionPool.get(dbConfig.name).borrow())) { db =>
      db localTx { implicit session =>
        Try {
          val queries = sqlScript.split(";")
          queries.foreach { query =>
            SQL(query).execute.apply
          }
        } match {
          case Success(_) =>
            logger.debug(s"Patched script")
          case Failure(ex) =>
            throw ex
        }
      }
    }
  }
}
