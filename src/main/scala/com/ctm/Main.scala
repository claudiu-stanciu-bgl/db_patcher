package com.ctm

import java.sql.SQLException

import akka.actor.ActorSystem
import com.ctm.messages.DatabaseConfig
import scalikejdbc._

import scala.collection.SortedMap
import scala.io.Source
import scala.util.{Failure, Success, Try}
import com.typesafe.scalalogging.StrictLogging

object Main extends App with StrictLogging {
  Try {
    //    val system = ActorSystem("system")
    //    val sqlExecutor = system.actorOf(Props[SqlExecutor])
    //    val db: DatabaseConfig = new DatabaseConfig("db1", "claudiustanciu", "", "jdbc:postgresql://localhost:5432/my_database")
    //    val sqlString = "select * from mytable"
    Class.forName("org.postgresql.Driver")

    val sql0 = SqlQuery("sql/query0.sql", "sql/query0_rollback.sql")
    val sql1 = SqlQuery("sql/query1.sql", "sql/query1_rollback.sql")
    val sql2 = SqlQuery("sql/query2.sql", "sql/query2_rollback.sql")

    val db1 = new DatabaseConfig("db1", "claudiustanciu", "", "jdbc:postgresql://localhost:5432/my_database1")
    ConnectionPool.add("db1", db1.url, db1.user, db1.password)
    val db2 = new DatabaseConfig("db2", "claudiustanciu", "", "jdbc:postgresql://localhost:5432/my_database2")
    ConnectionPool.add("db2", db2.url, db2.user, db2.password)

    val dbList = List(db1, db2)
    val sqlPatches = SortedMap(0 -> sql0, 1 -> sql1, 2 -> sql2)

    dbList.foreach(dbConfig => {
      logger.info(s"executing queries on ${dbConfig.name}")
      try {
        using(DB(ConnectionPool.get(dbConfig.name).borrow())) { db =>
          db localTx { implicit session =>
            sqlPatches.foreach {
              case (sqlIndex, sqlConfig) => {

                val patchScript = Source.fromResource(sqlConfig.patchFile).getLines.mkString
                logger.info(s"executing query script: ${sqlConfig.patchFile}")
                val patchQueries = patchScript.split(";")
                patchQueries.foreach(query => {
                  logger.info(s"executing query #$sqlIndex")
                  logger.info(s"executing query $query")
                  try {
                    SQL(query).execute.apply
                  } catch {
                    case ex: SQLException => {
                      logger.error(ex.getMessage)
                      logger.error(ex.getSQLState)
                    }
                  }
                })
              }
            }
          }
        }
        ()
      }
      catch {
        case ex: SQLException => {
          logger.error(ex.getMessage)
          logger.error(ex.getSQLState)
        }
        case ex: Exception => logger.error(ex.getMessage)
      }
    }
    )

    //    sqlExecutor ! ExecuteSql(db, sqlString)
    //    system.terminate()
  }

  match {

    case Success(_) =>
      println("System finished")
      sys.exit(0)
    case Failure(ex) =>
      println("Exception " + ex.getMessage)
      sys.exit(1)
  }
}
