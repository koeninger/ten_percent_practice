package sandbox.ch7

object Folds {
  def map[A, B](xs: List[A])(fn: A => B): List[B] = {
    xs.foldRight(List.empty[B])((x, acc) => fn(x) :: acc)
  }

  def flatMap[A, B](xs: List[A])(fn: A => List[B]): List[B] = {
    xs.foldRight(List.empty[B])((x, acc) => fn(x) ++ acc)
  }

  def filter[A](xs: List[A])(fn: A => Boolean): List[A] = {
    xs.foldRight(List.empty[A])((x, acc) =>
      if (fn(x)) {
        x :: acc
      } else {
        acc
      }
    )
  }

  def sum[A](xs: List[A])(implicit ev: Numeric[A]): A = {
    xs.foldLeft(ev.zero)((acc, x) => ev.plus(acc, x))
  }
}
