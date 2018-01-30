package sandbox.ch4

import cats.Eval

object UseEval {
  def foldRight[A, B](as: List[A], acc: B)(fn: (A, B) => B): Eval[B] =
    as match {
      case head :: tail =>
        Eval.defer(foldRight(tail, acc)(fn)).map(t => fn(head, t))
      case Nil =>
        Eval.now(acc)
    }
}
