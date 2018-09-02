package com.ctm

import akka.actor.{ActorSystem, Props}
import com.ctm.actors.{ExecuteSql, SqlExecutor}
import com.ctm.messages.DatabaseConfig
import scalikejdbc._
import org.apache.logging.log4j.scala.Logging
import scala.collection.SortedMap
import scala.io.Source
import scala.util.{Failure, Success, Try}

object Main extends App with Logging{
  Try {
    val system = ActorSystem("system")
    val sqlExecutor = system.actorOf(Props[SqlExecutor])
    val db: DatabaseConfig = new DatabaseConfig("db1", "claudiustanciu", "", "jdbc:postgresql://localhost:5432/my_database")
    val sqlString = "select * from mytable"
    //    Class.forName("\t\norg.postgresql.Driver")


    val sql1 = SqlQuery("sql/query1.sql", "sql/query1_rollback.sql")
    val sql2 = SqlQuery("sql/query2.sql", "sql/query2_rollback.sql")

    val db1 = new DatabaseConfig("db1", "claudiustanciu", "", "jdbc:postgresql://localhost:5432/my_database1")
    ConnectionPool.add("db1", db1.url, db1.user, db1.password)
    val db2 = new DatabaseConfig("db2", "claudiustanciu", "", "jdbc:postgresql://localhost:5432/my_database2")
    ConnectionPool.add("db2", db2.url, db2.user, db2.password)

    val dbList = List(db1, db2)
    val sqlPatches = SortedMap(1 -> sql1, 2 -> sql2)

    dbList.foreach(dbConfig => {
      logger.info(s"executing query on ${dbConfig.name}")
      using(DB(ConnectionPool.get(dbConfig.name).borrow())) { db =>
        db.readOnly { implicit session =>
          sqlPatches.foreach((sqlConfig: (Int, SqlQuery)) => {
            val patchQuery = Source.fromFile(sqlConfig._2.patchFile).getLines.mkString
            logger.info(s"executing query file: ${sqlConfig._2.patchFile}")
            sql"${patchQuery}".executeUpdate()
          })
        }
      }
      ()
    })
    //    sqlExecutor ! ExecuteSql(db, sqlString)
    //    system.terminate()
  } match {

    case Success(_) =>
      println("Initialised system successfully")
    case Failure(ex) =>
      println("Exception " + ex.getMessage)
      System.exit(1)
  }
}
