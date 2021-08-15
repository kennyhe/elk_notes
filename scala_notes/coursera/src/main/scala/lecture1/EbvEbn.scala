package lecture1

object EbvEbn {
  def loop: Boolean = loop  // infinite loop

  def orEbv(a: Boolean, b: Boolean) = if a then true else b

  def orEbn(a: Boolean, b: => Boolean) = if a then true else b
}
