package sandbox.ch9

import scala.concurrent.{ ExecutionContext, Future }

import cats.Monoid
import cats.instances.future._
import cats.instances.vector._
import cats.syntax.foldable._
import cats.syntax.traverse._

object MapReduceCats {
  def parallelFoldMap[A, B](values: Vector[A])(fn: A => B)(implicit ec: ExecutionContext, mb: Monoid[B]): Future[B] = {
    val batchSize = 1 + (values.size / Runtime.getRuntime.availableProcessors)
    values.
      grouped(batchSize).toVector.
      traverse(v => Future(v.foldMap(fn))).
      map(_.combineAll)
  }
}
