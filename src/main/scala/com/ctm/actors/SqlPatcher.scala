package com.ctm.actors

import akka.actor.{Actor, ActorSystem, Props, Terminated}
import akka.pattern.ask
import akka.util.Timeout
import com.ctm._
import com.typesafe.scalalogging.StrictLogging

import scala.util.control.Breaks._
import scala.concurrent.Await
import scala.concurrent.duration._
import scala.io.Source

case class ApplyPatch(db: Any, patches: Any)

class SqlPatcher(patches: Seq[SqlQuery]) extends Actor with StrictLogging {

  //  val patchFiles: immutable.IndexedSeq[String] = sqlPatches.
  //  val rollbackFiles: immutable.IndexedSeq[String] = sqlPatches.values.map(_.rollbackFile).toIndexedSeq

  override def preStart(): Unit = logger.info(s"Started actor SqlPatcher ${self.hashCode()}")

  override def postStop(): Unit = logger.info(s"Stopped actor SqlPatcher ${self.hashCode()}")

  override def receive: Receive = {

    case Rollback(db, index) => {
      logger.info("Applying rollback")
      val rollbackSqlPatches = patches.sorted.takeWhile(_.index < index).reverse
      self ! Patch(db, rollbackSqlPatches, true)
    }

    case PatchDB(db) => {
      val sqlPatches = patches.sorted
      self ! Patch(db, sqlPatches)
    }

    case Patch(db, sqlPatches, isRollback) => {
      implicit val timeout = Timeout(5 seconds)
      val system = ActorSystem("system")
      val sqlExecutor = system.actorOf(Props[SqlExecutor])
      breakable {
        sqlPatches.foreach {
          sqlPatch: SqlQuery => {
            logger.info(s"executing query script ${sqlPatch.patchFile}")
            logger.info(s"executing query on ${db.name}")
            logger.info(s"executing query #${sqlPatch.index}")
            val sqlScript = Source.fromResource(sqlPatch.patchFile).getLines.mkString("\n")
            val queries = sqlScript.split(";")

            queries.foreach {
              query => {
                val ret = sqlExecutor ? ExecuteSql(db, query)
                val status = Await.result(ret, 1.minute).asInstanceOf[Boolean]
                if (!status) {
                  if (!isRollback) {
                    self ! Rollback(db, sqlPatch.index)
                    logger.warn(s"Caught exception while patching. Rolling back from #${sqlPatch.index}")
                    break
                  }
                  else {
                    logger.error("Caught exception while rollbacking. Terminating")
                    break
                  }
                }

              }
            }
          }


        }
        logger.info("Terminated patching")
        system.stop(self)
      }

    }


  }
}


