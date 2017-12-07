package sandbox.ch4

object Id {
  type Id[A] = A

  implicit def idMonad = new Monad[Id] {
    def pure[A](a: A): Id[A] = a

    def flatMap[A, B](fa: Id[A])(func: A => Id[B]): Id[B] = func(fa)
  }
}
