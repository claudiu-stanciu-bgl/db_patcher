package com.comparethemarket.dbpatcher.config

import java.io.File

object DbPatch {
  def apply(patchFile: File): DbPatch = {
    val patchIndex = patchFile.getName.split("_").head.toInt
    new DbPatch(patchIndex, patchFile)
  }
}

class DbPatch(val index: Int, val patchFile: File) extends Ordered[DbPatch] {
  override def compare(that: DbPatch): Int =
    index.compareTo(that.index)
}