package algo.ch3

import scala.collection.mutable.StringBuilder

class SingleLinkedList[T]() {
  import SingleLinkedList._

  protected var top: Node[T] = null
  protected var bottom: Node[T] = null

  def fold[R](zero: R)(combine: (R, T) => R): R = {
    var r = zero
    var i = top
    while (i != null) {
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

  def peekTop: Option[T] = Option(top).map(_.item)

  def peekBottom: Option[T] = Option(bottom).map(_.item)

  def addTop(t: T) {
    val n = new Node(t, null)
    if (bottom == null) {
      bottom = n
    }
    if (top == null) {
      top = n
    } else {
      n.next = top
      top = n
    }
  }

  def addBottom(t: T) {
    val n = new Node(t, null)
    if (top == null) {
      top = n
    }
    if (bottom == null) {
      bottom = n
    } else {
      bottom.next = n
      bottom = n
    }
  }

  /* remove first node matching t, starting from top */
  def removeTop(t: T) {
    var i = top
    var p: Node[T] = null
    while (i != null && i.item != t) {
      p = i
      i = i.next
    }
    if (i != null) {
      if (p == null) {
        // found first item in list
        top = i.next
      } else {
        p.next = i.next
      }
      if (bottom eq i) {
        bottom = p
      }
    }
  }
}

object SingleLinkedList {
  protected class Node[T](var item: T, var next: Node[T])

  def largest[T](list: SingleLinkedList[T])(implicit o: Ordering[T]): Option[T] = {
    list.fold(Option.empty[T])((r, t) => {
      if (r.isEmpty) {
        Some(t)
      } else {
        r.map(x => o.max(x, t))
      }
    })
  }
}
