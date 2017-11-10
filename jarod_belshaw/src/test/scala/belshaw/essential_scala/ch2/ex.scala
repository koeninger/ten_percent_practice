package belshaw.essential_scala.ch2

import org.scalatest._

class Ch2Spec extends FlatSpec with Matchers {

"calc" should "square and cube correctly" in {
  Calc.square(2.0) should be (4.0)
  Calc.cube(2.0) should be (8.0)
}
"calc2 " should "square and cube correctly" in {
  Calc2.square(2.0) should be (4.0)
  Calc2.cube(2.0) should be (8.0)
  
  Calc2.square(2) should be (4.0)
  Calc2.cube(2) should be (8.0)
}


}
