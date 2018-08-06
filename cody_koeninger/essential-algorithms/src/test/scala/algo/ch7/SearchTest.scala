package algo.ch7

import org.scalatest.FunSuite
import scala.util.Random

class SearchTest extends FunSuite {
  val maxSize = Random.nextInt(10000)
  def randArray = Array.fill(maxSize)(Random.nextInt).sorted

  test("binary") {
    val a = randArray
    assert(Search.binary(a, a(Random.nextInt(maxSize))))
  }

  test("chooseMid") {
    val a = (0 to 10).toArray
    assert(Search.chooseMid(a, 3, 0, 10) === 3)
    assert(Search.chooseMid(a, 7, 5, 10) === 7)
  }

  test("interpolation") {
    val a = randArray
    assert(Search.interpolation(a, a(Random.nextInt(maxSize))))
  }

}
