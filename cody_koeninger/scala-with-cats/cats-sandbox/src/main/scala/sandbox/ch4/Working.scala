package sandbox.ch4

import scala.concurrent._
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

import cats.data.Writer
import cats.instances.vector._
import cats.syntax.applicative._
import cats.syntax.writer._

object Working {
  type Logged[A] = Writer[Vector[String], A]

  def slowly[A](body: => A): A =
    try {
      body
    } finally {
      Thread.sleep(100)
    }

  def factorial(n: Int): Logged[Int] = {
    slowly(if (n == 0) 1.pure[Logged] else factorial(n - 1).map(_ * n)).flatMap { ans =>
      Vector(s"fact $n $ans").tell.map(_ => ans)
    }
  }

  def factorialForSyntax(n: Int): Logged[Int] = {
    for {
      ans <- if (n == 0) 1.pure[Logged] else factorial(n - 1).map(_ * n)
      _ <- Vector(s"fact $n $ans").tell
    } yield {
      ans
    }
  }

  def main(args: Array[String]): Unit = {
    Await.result(Future.sequence(Vector(
      Future(factorialForSyntax(3)),
      Future(factorial(3))
    )), 5.seconds).map(_.run).foreach(println)
  }
}
