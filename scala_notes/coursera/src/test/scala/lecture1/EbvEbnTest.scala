package lecture1

import scala.util.Properties

import org.junit.experimental.categories.Category

import lecture1.EbvEbn._

class Slow extends munit.Tag("Slow")
class Fast extends munit.Tag("Fast")

@Category(Array(classOf[Fast]))
class EbvEbnTest extends munit.FunSuite:
  test("No difference for values") {
    assert(orEbn(true, false) == true)
    assert(orEbn(true, true) == true)
    assert(orEbn(false, true) == true)
    assert(orEbn(false, false) == false)

    assert(orEbv(true, false) == true)
    assert(orEbv(true, true) == true)
    assert(orEbv(false, true) == true)
    assert(orEbv(false, false) == false)
  }

  test("Ebn can shortcut and not impacted by infinite loop".only) {
    assume(Properties.isLinux, "this test runs only on Linux")
    assume(Properties.versionNumberString.startsWith("2.13"), "this test runs only on Scala 2.13")

    assert(orEbn(true, loop) == true)
  }

@Category(Array(classOf[Slow]))
class EbvInfiniteTest extends munit.FunSuite:
  test("Ebv falls into infinite loop".ignore) {
    assert(orEbv(true, loop) == true)  // don't run it, otherwise wait for life long!
  }
