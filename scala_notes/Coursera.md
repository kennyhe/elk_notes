# Coursera notes
Course URL: https://www.coursera.org/learn/scala-functional-programming/home/welcome

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
