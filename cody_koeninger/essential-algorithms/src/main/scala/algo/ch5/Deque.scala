package algo.ch5

import scala.collection.mutable.StringBuilder
import scala.math.Ordering

class Deque[T]() {
  import Deque._

  // sentinels, not actually holding values
  private val top = new Sentinel[T]
  private val bottom = new Sentinel[T]
  top.next = bottom
  bottom.prev = top

  def fold[R](zero: R)(combine: (R, T) => R): R = {
    var r = zero
    var i = top.next
    while (i != bottom) {
      r = combine(r, i.item)
      i = i.next
    }
    r
  }

  override def toString: String = {
    val b = new StringBuilder
    val prefix = "("
    b ++= prefix
    fold(b)((r, t) => {
      r ++= t.toString
      r ++= ", "
    })
    (if (b.length > prefix.length) {
      b.dropRight(2)
    } else {
      b
    }).++=(")").toString
  }

  def pushTop(t: T) = insertCell(top, new Cell(t, null, null))

  def pushBottom(t: T) = insertCell(bottom.prev, new Cell(t, null, null))

  def peekTop(): Option[T] = {
    val x = top.next
    if (x == bottom) {
      None
    } else {
      Some(x.item)
    }
  }

  def peekBottom(): Option[T] = {
    val x = bottom.prev
    if (x == top) {
      None
    } else {
      Some(x.item)
    }
  }

  def popTop(): Option[T] = {
    val x = top.next
    if (x == bottom) {
      None
    } else {
      deleteCell(x)
      Some(x.item)
    }
  }

  def popBottom(): Option[T] = {
    val x = bottom.prev
    if (x == top) {
      None
    } else {
      deleteCell(x)
      Some(x.item)
    }
  }

  def deleteAll(t: T) {
    var i = top.next
    while (i != bottom) {
      var n = i.next
      if (i.item == t) {
        deleteCell(i)
      }
      i = n
    }
  }

  def isSorted(implicit cmp: Ordering[T]): Boolean = {
    fold((None: Option[T], true))((accum, x) => accum match {
      case (_, false) => (None, false)
      case (None, true) => (Option(x), true)
      case (Some(prior), true) => (Option(x), cmp.lteq(prior, x))
    })._2
  }
}

object Deque {
  private trait Node[T] {
    def item: T
    var prev: Node[T]
    var next: Node[T]
  }
  private class Cell[T](var item: T, var prev: Node[T], var next: Node[T]) extends Node[T]
  private class Sentinel[T](var prev: Node[T] = null, var next: Node[T] = null) extends Node[T] {
    def item: T = throw new Exception("tried to get an item from the sentinel at top or bottom of list")
  }

  private def insertCell[T](after: Node[T], cell: Cell[T]) {
    cell.prev = after
    cell.next = after.next
    after.next = cell
    cell.next.prev = cell
  }
  private def deleteCell[T](cell: Node[T]) {
    cell.prev.next = cell.next
    cell.next.prev = cell.prev
    cell.next = null
    cell.prev = null
  }
}
