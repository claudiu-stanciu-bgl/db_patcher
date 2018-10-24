package com.comparethemarket.dbpatcher.config

import java.io.File

object DbPatchesHelper {
  def apply(patchDir: File, isRollback: Boolean): Array[DbPatch] = {
    val files = getFiles(patchDir)
      .filter(_.toString.toLowerCase.contains("rollback").equals(isRollback))
      .map(DbPatch(_))

    if (isRollback)
      files.sorted(Ordering[DbPatch].reverse)
    else
      files.sorted(Ordering[DbPatch])
  }

  def getFiles(dir: File): Array[File] = {
    dir.listFiles().filter(_.isFile).filter(_.getName.endsWith("sql"))
  }

}
