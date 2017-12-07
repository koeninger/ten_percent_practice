package sandbox.ch4

trait Monad[F[_]] {
  def pure[A](a: A): F[A]

  def flatMap[A, B](fa: F[A])(func: A => F[B]): F[B]

  def map[A, B](fa: F[A])(func: A => B): F[B] =
    flatMap(fa)(a => pure(func(a)))
}
