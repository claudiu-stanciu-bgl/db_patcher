package com.comparethemarket.dbpatcher

import scala.io.Source

import com.typesafe.scalalogging.StrictLogging

object DbPatcher extends StrictLogging {
  def patch(db: DatabaseConfig, sqlPatches: Seq[DbPatch]) {
    logger.info(s"Patching db ${db.name}")
    sqlPatches.foreach {
      sqlPatch: DbPatch => {
        logger.info(s"Executing query script ${sqlPatch.patchFile}")
        logger.info(s"Executing query #${sqlPatch.index}")
        val sqlScript = Source.fromFile(sqlPatch.patchFile).getLines.mkString("\n")
        QueryExecutor(db, sqlScript)
      }
    }
    logger.info(s"Finished patching db ${db.name}")
  }

}
