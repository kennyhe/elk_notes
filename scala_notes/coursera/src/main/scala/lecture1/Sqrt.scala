package lecture1
import Math._

object Sqrt {
  def sqrt(x: Double) = {

    def sqrtIter(guess: Double): Double =
      if (isGoodEnough(guess)) guess
      else sqrtIter(improve(guess))

    def isGoodEnough(guess: Double) =
      if x >= 1e6 || x < 1e-6 then
        abs(2 * log(guess) - log(x)) < 1e-6
      else
        abs(guess * guess - x) < 1e-6

    def improve(guess: Double) = (guess + x / guess) / 2

    sqrtIter(1.0)
  }

}
