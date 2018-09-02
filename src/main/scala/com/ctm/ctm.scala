package com.ctm

import com.ctm.messages.DatabaseConfig


case class ExecuteSql(db: DatabaseConfig, query: String)

case class FailedSql(queryId: Int)

case class PatchDB(db: DatabaseConfig)

case class Patch(db: DatabaseConfig, sqlPatches: Seq[SqlQuery], isRollback: Boolean = false)

case class Rollback(db: DatabaseConfig, index: Int)