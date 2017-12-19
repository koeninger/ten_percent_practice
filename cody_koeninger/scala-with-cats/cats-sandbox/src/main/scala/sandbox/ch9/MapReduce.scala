package sandbox.ch9

import cats.Monoid
import scala.concurrent.{ ExecutionContext, Future }
import cats.syntax.traverse._
import cats.instances.list._
import cats.instances.future._

object MapReduce {
  def foldMap[A, B: Monoid](values: Vector[A])(fn: A => B): B = {
    val mb = implicitly[Monoid[B]]
    values.map(fn).foldLeft(mb.empty)(mb.combine _)
  }

  def parallelFoldMap[A, B](values: Vector[A])(fn: A => B)(implicit ec: ExecutionContext, mb: Monoid[B]): Future[B] = {
    val batchSize = 1 + (values.size / Runtime.getRuntime.availableProcessors)
    val batches = values.grouped(batchSize).toList
    batches.traverse(v => Future(foldMap(v)(fn))).
      map(_.foldLeft(mb.empty)(mb.combine _))
  }
}
