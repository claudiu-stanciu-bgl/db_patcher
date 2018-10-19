package com.comparethemarket.dbpatcher

import scala.io.Source

import com.comparethemarket.dbpatcher.config.{DatabaseConfig, DbPatch}
import com.typesafe.scalalogging.StrictLogging

object DbPatcher extends StrictLogging {
  def patch(db: DatabaseConfig, sqlPatches: Seq[DbPatch], fromPatchIndex: Int): Unit = {
    logger.info(s"Patching db '${db.name}' from patch index #${fromPatchIndex}")
    sqlPatches
      .filter(_.index >= fromPatchIndex)
      .foreach {
        sqlPatch: DbPatch => {
          logger.info(s"Executing query script ${sqlPatch.patchFile}")
          logger.info(s"Executing patch #${sqlPatch.index}")
          val sqlScript = Source.fromFile(sqlPatch.patchFile).getLines.mkString("\n")
          QueryExecutor.runQuery(db, sqlScript)
          logger.info(s"Finished patch #${sqlPatch.index}")

        }
      }
    logger.info(s"Finished patching db '${db.name}'")
  }

}
