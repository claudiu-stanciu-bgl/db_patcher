package com.comparethemarket.dbpatcher

import java.io.File

import com.comparethemarket.dbpatcher.config.DbPatch
import org.scalatest.{FlatSpec, Matchers}

class DbPatchSpec extends FlatSpec with Matchers {
  "DbPatch" should "parse a file and create a new DbPatch instance" in {
    val input = new File("/my/path/sql/123_query.sql")
    val conversionOutput = DbPatch(input)
    val expectedOutput = new DbPatch(123, input)

    conversionOutput.index shouldBe expectedOutput.index
    conversionOutput.patchFile shouldBe expectedOutput.patchFile
  }

}
