package com.ctm

import akka.actor.{ActorSystem, Props}
import com.ctm.actors.SqlPatcher
import com.ctm.messages.DatabaseConfig
import com.typesafe.scalalogging.StrictLogging
import scalikejdbc._

import scala.util.{Failure, Success, Try}

object Main extends App with StrictLogging {
  Try {
    val system = ActorSystem("system")

    Class.forName("org.postgresql.Driver")

    val sql0 = new SqlQuery(0, "sql/query0.sql", "sql/query0_rollback.sql")
    val sql1 = new SqlQuery(1, "sql/query1.sql", "sql/query1_rollback.sql")
    val sql2 = new SqlQuery(2, "sql/query2.sql", "sql/query2_rollback.sql")

    val db1 = new DatabaseConfig("db1", "claudiustanciu", "", "jdbc:postgresql://localhost:5432/my_database1")
    ConnectionPool.add("db1", db1.url, db1.user, db1.password)
    val db2 = new DatabaseConfig("db2", "claudiustanciu", "", "jdbc:postgresql://localhost:5432/my_database2")
    ConnectionPool.add("db2", db2.url, db2.user, db2.password)

    val dbList = List(db1, db2)
    val sqlPatches = Seq(sql0, sql1, sql2)

    val sqlPatcher = system.actorOf(Props(new SqlPatcher(sqlPatches)))

    dbList.foreach(sqlPatcher ! PatchDB(_))

    system.
  }

  match {

    case Success(_) =>
      println("Patching initiated")
    case Failure(ex) =>
      println("Exception " + ex.getMessage)
      sys.exit(1)
  }
}
