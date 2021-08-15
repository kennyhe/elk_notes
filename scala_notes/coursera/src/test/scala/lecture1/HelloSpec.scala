package lecture1

class HelloSpec extends munit.FunSuite:
  test("Hello should start with H") {
    assert("Hello".startsWith("H"))
  }
