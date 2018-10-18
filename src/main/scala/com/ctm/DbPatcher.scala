package com.ctm

import scala.io.Source

import com.typesafe.scalalogging.StrictLogging

import com.ctm.messages.DatabaseConfig

object DbPatcher extends StrictLogging {
  def patch(db: DatabaseConfig, sqlPatches: Seq[SqlQuery]) {
    sqlPatches.foreach {
      sqlPatch: SqlQuery => {
        logger.info(s"executing query script ${sqlPatch.patchFile}")
        logger.info(s"executing query #${sqlPatch.index}")
        val sqlScript = Source.fromResource(sqlPatch.patchFile).getLines.mkString("\n")
        val queries = sqlScript.split(";")

      }
    }

    logger.info("Finished patching")
  }

}
