# Coursera notes
Course URL: https://www.coursera.org/learn/scala-functional-programming/home/welcome

Cheating sheet: https://github.com/lampepfl/progfun-wiki/blob/gh-pages/CheatSheet.md

## Concepts
1. EBV (evaluate by value) and EBN (evaluate by name)
  * EBV: val, var => Evaluate the value immediately
  * EBN: def => Only evaluate when necessary
  * Example:
```
def loop: Boolean = loop  // infinite loop, cannot evaluate
def and(a: Boolean, b: Boolean) =   // parameter b will be immediately evaluated
  if a then b else false
def and2(a: Boolean, b: => Boolean) =  // parameter b is EBN, won't be evaluated
  if a then b else false
// and(false, loop) will enter infinite loop because EBV, loop will be evaluated
@main def test = {and2(false, loop); and(false, loop)}
```

2. Tail Recursion
Example: GCD (Greatest Common Divisor) vs. factorial:
```
def gcd(a: Int, b: Int): Int = if (b == 0) then a else gcd(b, a % b)
def factorial(n: Int): Int = if (n <= 1) then 1 else n * factorial(n - 1)
```
The difference: gcd() call itself, then no extra action. So the stack frame can be reused. factorial() call itself but need to multiply with n.

  * If a function calls itself as its last action, the function's stack frame can be reused. This is called tail recursion (iterative processes, nothing different between a while loop).
  * If the last action of a function consists of calling a function (may be itself), one stack frame would be sufficient for both functions. Such calls are called tail-calls.
  * @scala.annotation.tailrec: Optimize recursive calls.
  * Only directly recursive calls to the current function are optimized. If the actual implementation is not tail-recursive, an error would be issued.




3. Higher order functions
Functions that can take a function as parameter or return functions. e.g.:
```
def sum(f: Int => Int): (Int, Int) => Int =
  def sumf(a: Int, b: Int): Int = f(a) + f(b)
  sumf
```
In this case, "sum" has one parameter as a function, and returns another function.
If the parameter is "def sqr(r: Int): Int = r * r", then the out put should be
a function to calculate "a\*a + b\*b". To call the function:
```
val a = sumf(x => x * x)(1, 10) // result is 101
def cube(x) = x * x * x
val b = sumf(cube)(1, 3)  // result is 28
```

4. Currying
Converting a function with multiple arguments into a function with a single
argument that returns another function.
```
def f(a: Int, b: Int): Int = {...}
val g: Int => Int => Int = f.curried  // g's type is: Int => (Int => Int)
g(1)(2)  // make call. equals to: f(1, 2)
```

4.
