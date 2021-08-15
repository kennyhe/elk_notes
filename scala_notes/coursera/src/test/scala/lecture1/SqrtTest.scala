package lecture1
import lecture1.Sqrt.sqrt

class SqrtTest extends munit.FunSuite:
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
