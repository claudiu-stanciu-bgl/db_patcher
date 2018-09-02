package com.ctm

class SqlQuery(val index: Int, val patchFile: String, val rollbackFile: String) extends Ordered[SqlQuery] {
  override def compare(that: SqlQuery): Int =
    index.compareTo(that.index)
}