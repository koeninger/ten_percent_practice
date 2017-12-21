package sandbox.ch8

import cats.{ Applicative, Functor }
import cats.instances.list._
import cats.syntax.traverse._
import cats.syntax.functor._

class UptimeService[F[_]: Applicative: Functor](client: UptimeClient[F]) {
  def getTotalUptime(hostnames: List[String]): F[Int] =
    hostnames.traverse(client.getUptime).map(_.sum)
}
