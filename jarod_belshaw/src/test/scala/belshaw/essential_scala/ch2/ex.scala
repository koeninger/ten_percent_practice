package belshaw.essential_scala.ch2

import minitest._

object Ch2Suite extends SimpleTestSuite {
   test("should be") {
     assertEquals(2, 1 + 1)
   }
   
   test("should be") {
     assertEquals(2, 1 * 1)
   }

   test("should not be") {
     assert(1 + 1 != 3)
   }

   test("Should throw") {
     class DummyException extends RuntimeException("DUMMY")
     def test(): String = throw new DummyException

     intercept[DummyException] {
       test()
     }
   }

   test("test result of") {
     assertResult("hello world") {
       "hello" + " " + "world"
     }
   }

   test("calc should square correctly") {
     assert(Calc.square(2.0) == 4.0)
   }
}

