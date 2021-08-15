# Basic grammar
1. val vs. var
2. Types: built in type, auto type inference (like auto type in modern C++). scala.math.BigInt, BigDecimal supports more accurate operations.
  * To init a BigInt, just init it with a String. Otherwise the compiler report "number too large" error on the int literal.
  * The same for the BigDecimal. Don't use a double literal, otherwise it becomes inaccurate.
3. Wildcard is "_", not "*". e.g. import java.util._ All classes in java.lang._ are imported.
4. Operators are methods: "1+5" is (1).+(5), returns 6.
5. Rich Wrapper. (Refer to Rich Wrapper section for details)
6. Range: Like python, and supports different number type and Char:
  * Inclusive both: 1 to 5   // Range 1 to 5, 1.to(5), type is scala.collection.immutable.Range.Inclusive
  * Not include the end (python): 1 until 5   // Range 1 until 5, 1.until(5), Range(1, 5, 1). Type is scala.collection.immutable.Range.Exclusive
  * Specify step: 1 to 10 by 2
  * Float series: 0.5f to 5.9f by 0.8f   // Note: The number may not be accurate. Some numbers in the series might be 3.6999999998 rather than 3.7
7. Console I/O:
  * scala.io.StdIn.readInt, readDouble, readByte, readChar, readLine, ....
  * Output: print(), println(), printf(). They are defined in scala.Predef._ so need not import
  * System.err.println("error details")  // Output to STDERR
8. File I/O:
  * Write to a file:
```
import java.io.PrintWriter
val out = new PrintWriter("myfile")  // Default file writing folder: Where the scala application is started.
out.println("Hello")
for (i <- 1 to 5) out.println(i)
out.close()
```
  * Read from a file: 
```
import scala.io.Source
val f = Source.fromFile("myfile")
val lines = f.getLines   // no (), returns an iterator
for (line <- lines) println(line)
```
9. Control structures
  * if () {} else {}, while (){}, do {} while ()
  * val max = if (a > b) a else b
  * for (i <- range [condition])
  * for (i <- 1 to 5 if i % 2 != 0) println(i)
  * for (i <- 1 to 5 if i % 2 == 0; j <- 1 to 3 if j != i) println(i * j)
  * foreach: Refer to the collections
  * yield: Like python generated list: for (i <- 1 to 5) yield i  // Vector(1, 2, 3, 4, 5)
  * match statement: like a combination of function and switch...case, but *more powerful*:
```
val result = i match {
  case 1 => "one"
  case 2 => "two"
  case 3 | 4 => "three or four"
  case x if x < 20 => "Smaller than 20"  // if parentheses in case clause are optional
  case _ => "Others"
}

val booleanAsString = bool match {
    case true => "true"
    case false => "false"
}
def isTrue(a: Any) = a match {
    case 0 | "" => false  // Not necessarily the same type
    case _ => true
}
def getClassAsString(x: Any):String = x match {
    case s: String => s + " is a String"
    case i: Int => "Int"
    case f: Float => "Float"
    case l: List[_] => "List"
    case p: Person => "Person"
    case _ => "Unknown"
}
```
10. Type infer
Prefer to use type infer rather than implicitly specify the types, unless you need to be clear. In IDE, it should be possible to auto infer the type as well.
11. String concatenate: Like python
  * val str = s"Name: $firstName $mi $lastName"  // s like python "f". $prefix. Like shell script, can use ${var or expression} if the variable follows with a char.
  * val str = """{"name": "James"}"""  // """ to enclose a multi-line string. Note: Put a "|" in front of all lines after the first line and call the "stripMargin" method after the string to purge the leading spaces.
  * val str = f"$name%s is $height%2.2f meters tall"  // C-style formatting
  * raw"a\nb"  // do not trans \n to CrLf, or other special characters
  * ToDo: Understand the Advanced Usage in: https://docs.scala-lang.org/overviews/core/string-interpolation.html
12. Exception handling
  * Scala does not support checked exception. All exceptions are unchecked (Inherited from RuntimeException) and it's not mandatory to use try-catch to catch them.
  * Grammar:
```
import java.io.FileReader
import java.io.FileNotFoundException
import java.io.IOException

try {
    val f = new FileReader("input.txt")
    ...... // file ops
} catch {
    case ex: FileNotFoundException =>
        ....
    case ex: IOException =>
        ....
    case _:
        ....   // otherwise, make sure an exception is always handled
} finally {
    file.close()
}
```

13. Anonymous function
  * aList.map(\_ * 2): equals to aList.map(i => i * 2)
  * aList.filter(\_ > 5): filter items satisfy the condition




# Data Structures
1. Abstracted: scala.collection package includes all container/collection classes:
  * Traversable(trait) -> Iterable -> (Seq, Set, Map)
  * Seq -> (IndexedSeq, LinearSeq)
  * Set -> (SortedSet, BitSet)
  * Map -> SortedMap
2. Immutable (scala.collection.immutable.\_) and Mutable (scala.collection.mutable.\_)
3. List: immutable *linked-list*, all elements are with same type. (Comes from Lisp language)
  * Vector: an indexed immutable sequence. Works same as List in Java. (Scala list is immutable LinkedList)
  * head: Return first element only, the same behavior for strings, the first char
  * tail: Return a new list without the head, also for strings
  * take(n): Return first n elements (or all elements if length <= n)
  * val nums1 = List(1, 2, 3); val nums2 = Seq(1, 2, 3);  // both of them are list and equal. Seq is a trait (like Java interface) while List is an implementation
  * "::" operator to concat an element and a list (right sticky)
  * Other operators: element +: aList; aList :+ element;  (: indicates the side of a list); listA ++: ListB
  * Nil: empty List object. e.g. val intList = 1::2::3::Nil  // List(1, 2, 3)
  * List.range(0, 10)   // List(0, 1, 2, ..., 9)
  * (1 to 10 by 2).toList  // List(1, 3, 5, 7, 9)
  * ('a' to 'f' by 2).toList  // List('a', 'c', 'e')
  * myList.foreach(println)  // foreach(lambda) -> apply lambda to each element
  * myList.filter(\_ < 4).foreach(println)  // filter by prejucate and apply lambda
  * lists.map(\_ * 2)  // Map with lambda.
  * def foldLeft\[B](z: B)(op: (B, A) ? B): B  // init value z, then apply a one by one with the b, return the last b. e.g.: lists.foldLeft(0)(\_ + \_)  // sum of all elements in the list. 0 is init value, apply the operands to the lambda, which accept two parameters
  * Create a new List by updated: a.updated(index, v)  // change the value and return a new List. The index must be a valid index in the list. Cannot append. Can only update one item at a time.
4. Set: Search by hash. Can be either mutable or immutable. Immutable by default. Elements are in the same type
  * Note: By default the Set is immutable. var mySet = Set(0); mySet += 1  // It's valid. After the 2nd statement, a new mySet object is created. Both of them are immutable. If change "var" to "val", cannot assign a new reference to "mySet" and an error will be generated. Set object itself is immutable.
  * To create a mutable Set, needs to import scala.collection.mutable.Set. In that case, "mySet += 1" will not create a new object. The new element is added to mutable mySet.
  * Operations: +=, -=, ++= aSeq, --= aSeq
  * More set: SortedSet, LinkedHashSet, and more.
5. Map: Like Set, has mutable and immutable versions. Immutable by default. Keys are in same type, values are in same type.
 5.1. Basic accesses
  * Access by key: myMap(key). val myMap = Map("a"->1, "b"->2, ...). Not like python grammar!!!
  * Like List, myMap.updated(k, v) returns a new map. k can either exist or not. Can add only one item at a time.
  * Check exist: if (myMap.contains(key))   // check if key exists.
  * Add an entry: var myMap += (k -> v)  // For immutable map, create a new map.
  * For mutable map, update: myMap(k) = v or myMap += (k -> v), or myMap += (k1->v1, k2->v2, ...)
  * Iterate: for ((k, v) <- myMap) ..., for (k <- myMap.keys) ..., for (k <- myMap.values) ...
  * myMap.foreach { (k, v) => something_apply(k, v)}
  * myMap.foreach { case(k, v) => ... }  // what's the difference?
 5.2. Common Map functions (similar as Java)
  * keys(): return a set of keys
  * values(): return a iterable of values (could have duplicates)
  * contains(k): Test if map contains a key k
  * transform((k, v) => ...): The lambda transform the *values* of the map (apply the lambda to value and set)
  * filter a map by its keys: m.view.filterKeys(Set(2, 3)).toMap    // get a sub map with key (2, 3)
  * take(n): Get the first n elements from a Map   // elements in map are not sorted, except LinkedHashMap and TreeMap, and their sub classes.
6. Iterator: next, hasNext
  * Can manual construct an Iterator: val it = Iterator(1, 2, 3)
  * Access: while (it.hasNext) {it.next()}, or for (elem <- it) {elem}
  * grouped and sliding: Return sub iterators:
    * a grouped 3  // split to (n-1)/3+1 small groups)
    * a sliding 3  // to n - 2 small groups, with sliding window size 3
7. Array: mutable, indexible, all elements are in the same type.
  * val arr = new Array\[Type](n)  // Type, n is length
  * Can be initialized: val arr2 = Array(1, 2, 3)  // type can be infered as Int
  * Set or get value: arr(index)  // use (), not []
  * val arr = Array(12, 45, 33)   // Create an array with 3 elements (init values)
  * Multi-dimension array: val myMatrix = Array.ofDim\[Int](3,4)  // 3x4 int array, actual type is Array[Array[Int]]
  * val myCube = Array.ofDim\[String](3,2,4)  // Array[Array[Array[Int]]]
  * Access multiple dimension array: myCube(0)(1)(3)
  * Array size is fixed when declared. Like Java array.
  * Dynamic Array: scala.collection.mutable.ArrayBuffer: Like Java ArrayList
    * +=(add(elem)), ++=(addAll(iter)), insert(pos,elem), remove(pos), -=(remove), --=(removeAll).
8. Tuple: Can contain 2 to 22 elements in different type. Like Python tuple.
  * tuple = (1, "Hello", "H")
  * Access: tuple.\_1, tuple.\_2, ...
  * Good for quickly/temporarily group somethings together. If using the same tuples multiple times, it could be useful to declare a dedicated case class.
9. Common sequence methods:
  * map, filter, foreach, head, tail, take, takeWhile, drop, dropWhile, reduce
  * apply to: Array, ArrayBuffer, List, Vector, String, etc.
  * reduce(func): Apply the elements one by one
  * takeWhile and dropWhile: Apply the condition from the first element, and quit when the first element does not meet the condition. In the following examples:
    * List.range(1, 10).takeWhile(\_ > 5)  // return emptyList
    * List.range(1, 10).dropWhile(\_ > 5)  // List(1,2,...,10)



# Scala OOP
Naming convention: Follow Java naming conventions.
1. Class
Example 1:
```
class Counter {
    // fields
    private var value = 0

    // methods
    def increment(): Unit = {value += 1}  // Unit is "void" in Java, {} is optional if single statement
    def current(): Int = {value}   // getter, return type is optional if 
}

// initialize
val c1 = Counter()
val c2 = Counter    // can ignore the () if no parameters
c2.increment()      // ditto. Can be c2.increment
```

Example 2:
```
class Person(var firstName: String, var lastName: String) {
    def printFullName() = println(s"$firstName $lastName")
}
val p = new Person("Julia", "Kern")  // class parameters auto become members, no setters and getters required
println(p.firstName)
p.lastName = "Manes"
p.printFullName()
```
  * Constructor: The parameters are by default member fields
    * var parameters: Also getters, setters, and make the class mutable.
    * val parameters: Read-only fields. If all val parameters, class is immutable. (For functional programming, consider case class)
    * The primary constructor of a class is a combination of: constructor params; methods that are called in the body of the class; statements and expressions that are executed in the body of the class. (Unlike Java/Python)
    * All the statements/assignments are executed everytime when an Class instance is created (new). (Is there any "static" code?)
    * Auxiliary class constructors: by definig methods are named "this". Differntiate by different signature, and MUST call one of the previously defined constructors (this(....)).
    * We can also specify default values in class parameters to avoid auxiliary constructors (in some cases). Supports both named parameters and positional parameters (the same as python)

2. Method
  * def methodName(param1: Type1, param2: Type2): ReturnType = {body}
  * Return type can be infered and is optional. {} can be optional if only one statement in the body.
  * No return, then return type is "Unit" (equal to Java "void")
  * Python like named parameter and default values: log(message: String, level: String = "INFO") = {...}
  * In scala2, if no parameters, can call the method without ().
  * But in Scala3, methods must be always called with ().

3. Enumerations
  * Syntax:
```
sealed trait EnumName  // specify the Enum name as a sealed trait
case object Value1 extends EnumName  // specify the first value, Value1
case object Value2 extends EnumName  // specify the another value, Value2
....
```
  * The String value of an Enum value is the same.

4. Traits  (like Interfaces/abstracted classes in Java) Classes can also extend and "mixin" multiple traits. It's different from the "abstract class" (used in different scenarios) concept in Scala.
  * Like Java, the default access is "public"
  * class ClassName extends TraitName {...}  // "extends", not "implements"
  * class ClassA extends TraitB with TraitC with TraitD {...}  // extends multiple traits
  * override def methodA() = ...  // override an implemented method
  * val d = new Dog("Fido") with TraitA with TraitB  // Create a class instance and mixes the traits. Dog class instance mix TraitA and TraitB (both traits must have all concrete methods)

5.  Abstract class: For compatibility with Java (Java cannot understand Scala traits) to allow Java code to call Scala code
  * Syntax like a combination of Java&Scala syntax:
```
abstract class Pet (name: String) {  // read-only param name, constructor
    def speak(): Unit = println("Yo")   // concrete implementation
    def comeToMaster(): Unit            // abstract method
}

class Dog(name: String) extends Pet(name) {  // name is passed from constructor of Dog to constructor of Pet. (Like C++ init)
    override def speak() = println("Woof")
    def comeToMaster() = println("Here I come!")
}
```

5. Singleton Objects and Companion Objects
5.1 Singleton Objects
* Single instances, and all fields/methods are static
* Application object:
  * Run with scala command
  * Put into the body of an Object extends from App.
5.2 Companion Objects
* Object name is identical to a class name, and should be defined in the same file, and can access the private members of each other
* When compiled to Java byte code, the class and companion object are combined into one singe class. All members in the Companion Object are merged into the class as static members.

6. apply() and update() methods
6.1 apply() method
* apply method: Call the instance (instance as function) with params
* It can also be defined in Singleton Object, then when the Singleton object is called, the apply() method is called.
* If apply() method is defined in both a class and its Companion Object, when an istance is called, the apply() in the _class_ is called. When a class name is called, the apply() in the _Companion Object_ is called.
* An application example: Array, List
6.2 update() method
* Same as apply(), but used for updating the member values inside the instance or the static member values in the Companion object. It take parameters and target values. The last parameter is the value on the right side of "="
* Application example: assign the value of an Array object.


7. Inheritance
* Only main constructor can call the constructor of the parent/super classes
* "override" keyword is manatory/optional when overriding a non-abstract/abstrct method in super class(es).
* Can override the fields in the super class (change type?)

# Rich Wrapper
Purpose: Add additional feature methods to the class (without modifying a class, especially when it come from a library)!

How to:
```
object SomeObjectName {
    implicit class ClassName(instance: OptionalParamClassName => ReturnType) {
        def methodName(params: Type) => ReturnType = {....}
    }
}

// To use:
import SomeObjectName._
someInstance.methodName(params)  // someInstance can be a method call, or an instance, any object
```

Refer to: https://lprakashv.medium.com/making-ordinary-classes-rich-scala-ab7f991d690

Typical rich wrapper like: max, min, etc.




