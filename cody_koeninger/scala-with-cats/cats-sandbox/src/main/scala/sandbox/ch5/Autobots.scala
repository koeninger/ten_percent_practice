package sandbox.ch5

import cats.instances.future._
import cats.data.EitherT
import scala.concurrent.{ Await, Future }
import scala.concurrent.duration._
import scala.util.control.NonFatal
import scala.concurrent.ExecutionContext.Implicits.global

object Autobots {
  type Response[A] = EitherT[Future, String, A]

  val powerLevels = Map(
    "Jazz" -> 6,
    "Bumblebee" -> 8,
    "Hot Rod" -> 10
  )

  def getPowerLevel(autobot: String): Response[Int] = {
    EitherT[Future, String, Int](
      Future.successful(
        powerLevels.get(autobot).toRight(s"Unknown $autobot")))
  }

  def canSpecialMove(a1: String, a2: String): Response[Boolean] = {
    for {
      p1 <- getPowerLevel(a1)
      p2 <- getPowerLevel(a2)
    } yield {
      p1 + p2 > 15
    }
  }

  def tacticalReport(a1: String, a2: String): String = {
    Await.result(
      canSpecialMove(a1: String, a2: String).value.map {
        case Right(true) => s"$a1 and $a2 are good to go"
        case Right(false) => s"$a1 and $a2 need more power"
        case Left(msg) => s"Power level error: $msg"
      }.recover {
        case NonFatal(x) => s"Communication error: $x"
      },
      10.seconds
    )
  }
}
