package com.comparethemarket.dbpatcher.config

import java.io.File

object DbPatchesHelper {
  def apply(patchDir: File): Array[DbPatch] = {
    getFiles(patchDir)
      .filter(!_.toString.toLowerCase.contains("rollback"))
      .map(DbPatch(_))
      .sorted
  }

  def getFiles(dir: File): Array[File] = {
    dir.listFiles().filter(_.isFile)
  }

}
