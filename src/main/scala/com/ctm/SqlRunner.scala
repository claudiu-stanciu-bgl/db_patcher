package com.ctm

import java.sql.SQLException

import com.typesafe.scalalogging.StrictLogging
import scalikejdbc.{ConnectionPool, DB, SQL, using}

import com.ctm.messages.DatabaseConfig

object SqlRunner extends StrictLogging{

  def runQuery(db:DatabaseConfig, query: String): Unit ={
    logger.info(s"Executing query $query")

    using(DB(ConnectionPool.get(db.name).borrow())) { db =>
      db localTx { implicit session =>
        try {
          SQL(query).execute.apply
        } catch {
          case ex:SQLException => logger.error(s"Found exception ${ex}. Exiting...")
        }
      }
    }
  }
}
