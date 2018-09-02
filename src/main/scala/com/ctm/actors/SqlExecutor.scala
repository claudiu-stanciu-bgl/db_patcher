package com.ctm.actors

import akka.actor.{Actor, ActorLogging, Props}
import com.ctm.messages.DatabaseConfig
import scalikejdbc._


case class ExecuteSql(db: DatabaseConfig, sql: String)

object SqlExecutor {
  def props() = Props(new SqlExecutor)
}

class SqlExecutor extends Actor with ActorLogging {


  override def preStart(): Unit = log.info("Started actor")

  override def postStop(): Unit = log.info("Stopped actor")

  override def receive: Receive = {
    case ExecuteSql(db, sql) =>
      println(s"executing query on $db")
      using(DB(ConnectionPool.borrow())) { db =>
        db.autoCommit { implicit session =>
          sql"select * from mytable;".map(rs => println(s"${rs.string("field1")}|${rs.int("field2")}")).list().apply()
        }
      }

  }
}
