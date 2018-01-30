package sandbox.ch4

import cats.data.State

object PostfixCalc {
  type CalcState[A] = State[List[Int], A]

  def evalOne(sym: String): CalcState[Int] = {
    sym match {
      case "+" => op(_ + _)
      case "*" => op(_ * _)
      case "-" => op(_ - _)
      case "/" => op(_ / _)
      case i =>
        val int = i.toInt
        State { stack =>
          (int::stack, int)
        }
    }
  }

  private def op(fn: (Int, Int) => Int): CalcState[Int] = State { stack =>
    val x::y::rest = stack
    val a = fn(x, y)
    (a::rest, a)
  }

  def evalAll(input: List[String]): CalcState[Int] = {
    input match {
      case Nil => State { stack =>
        (stack, stack.head)
      }
      case x::xs => evalOne(x).flatMap(_ => evalAll(xs))
    }
  }
  def evalInput(str: String): Int = {
    evalAll(str.split(" ").toList).runA(Nil).value
  }
}
