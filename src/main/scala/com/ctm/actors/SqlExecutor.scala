package com.ctm.actors

import java.sql.SQLException

import akka.actor.{Actor, Props}
import com.ctm._
import com.typesafe.scalalogging.StrictLogging
import scalikejdbc._

object SqlExecutor {
  def props() = Props(new SqlExecutor)
}

class SqlExecutor extends Actor with StrictLogging {

  override def preStart(): Unit = logger.info(s"Started actor SqlExecutor ${self.hashCode()}")

  override def postStop(): Unit = logger.info(s"Stopped actor SqlExecutor ${self.hashCode()}")

  override def receive: Receive = {
    case ExecuteSql(db, query) =>

      logger.info(s"executing query $query")

      using(DB(ConnectionPool.get(db.name).borrow())) { db =>
        db localTx { implicit session =>
          try {
            SQL(query).execute.apply
            sender ! true
          } catch {
            case ex:SQLException =>
              sender ! false
//              throw ex
          }
        }
      }

  }
}
