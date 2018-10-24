package com.comparethemarket.dbpatcher

import scala.util.{Failure, Success, Try}

import com.comparethemarket.dbpatcher.config.DatabaseConfig
import com.typesafe.scalalogging.StrictLogging
import scalikejdbc.{ConnectionPool, using}

object QueryExecutor extends StrictLogging {

  def runQuery(dbConfig: DatabaseConfig, sqlScript: String): Unit = {
    using(ConnectionPool.get(dbConfig.name).borrow()) { conn =>
      conn.setAutoCommit(false)
      Try {
        val stmtOBj = conn.createStatement
        val queries = sqlScript.split(";")
          .map(_.trim)
          .filter(!_.startsWith("--"))
          .filter { line =>
            val lineLower = line.toLowerCase
            !(lineLower.contains("transaction") || lineLower.contains("commit"))
          }
          .filter(!_.isEmpty)
        queries.foreach { query =>
          logger.debug(s"Running query: '" + query + "'")
          stmtOBj.execute(query)
        }
      } match {
        case Success(_) =>
          conn.commit()
        case Failure(ex) =>
          logger.error(s"Found exception. Rollback ...")
          conn.rollback()
          throw ex
      }

    }


  }
}
