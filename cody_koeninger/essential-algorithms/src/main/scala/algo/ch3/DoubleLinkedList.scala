package algo.ch3

import scala.collection.mutable.StringBuilder

class DoubleLinkedList[T]() {
  import DoubleLinkedList._

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

  def addTop(t: T) = insertCell(top, new Cell(t, null, null))
  /*
   {
    val c = new Cell(t, top, top.next)
    top.next = c
    c.next.prev = c
   }
  }*/

  def addBottom(t: T) = insertCell(bottom.prev, new Cell(t, null, null))
  /*
     {
     val c = new Cell(t, bottom.prev, bottom)
     bottom.prev = c
     c.prev.next = c
     }
   */

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
}

object DoubleLinkedList {
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
