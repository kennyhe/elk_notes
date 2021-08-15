package lecture1
import lecture1.Sqrt.sqrt

class SqrtTest extends munit.FunSuite:
  test("sqrt(0) is 0") {
    val x = sqrt(0)
    assert(x == 0)
  }

  test("sqrt(negative number)") {
    interceptMessage[java.lang.RuntimeException]("-1.0 < 0"){
      val x = sqrt(-1.0)
    }
  }

  test("A normal number") {
    val x = sqrt(10)
    assert(3.1622 < x && x < 3.1623)
  }

  test("Another normal number") {
    val x = sqrt(0.04)
    assert(0.19999 < x && x < 0.20001)
  }

  test("A very large number") {
    val x = sqrt(1e20)
    assert(9.999999e9 < x && x < 1.000001e10)
  }

  test("A very tiny number") {
    val x = sqrt(4e-20)
    assert(1.999999e-10 < x && x < 2.000001e-10)
  }
