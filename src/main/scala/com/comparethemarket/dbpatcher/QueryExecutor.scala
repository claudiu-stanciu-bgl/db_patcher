package com.comparethemarket.dbpatcher

import scala.util.{Failure, Try}

import com.typesafe.scalalogging.StrictLogging
import scalikejdbc.TxBoundary.Try._
import scalikejdbc.{ConnectionPool, DB, SQL, using}

object QueryExecutor extends StrictLogging {

  def runQuery(dbConfig: DatabaseConfig, sqlScript: String): Unit = {
    logger.info(s"Executing sqlPatch")

    using(DB(ConnectionPool.get(dbConfig.name).borrow())) { db =>
      val result = db localTx { implicit session =>
        Try {
          val queries = sqlScript.split(";")
          queries.foreach { query =>
            SQL(query).execute.apply
          }
        }
      }
      result match {
        case Failure(ex) =>
          throw ex
      }
    }
  }
}
