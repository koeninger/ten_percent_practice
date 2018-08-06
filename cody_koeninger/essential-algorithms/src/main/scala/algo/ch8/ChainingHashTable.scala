package algo.ch8

import java.lang.Math.floorMod

class ChainingHashTable[K, V](bucketCount: Int) {
  private val buckets: Array[List[Entry[K, V]]] = Array.fill(bucketCount)(Nil)

  private var count = 0

  private def index(key: K): Int =
    floorMod(key.hashCode, bucketCount)

  def size = count

  def update(key: K, value: V): Unit = {
    val i = index(key)
    buckets(i).find(_.key == key) match {
      case None =>
        buckets(i) = Entry(key, value) :: buckets(i)
        count = count + 1
      case Some(entry) =>
        entry.value = value
    }
  }

  def apply(key: K): Option[V] = {
    val i = index(key)
    buckets(i).find(_.key == key).map(_.value)
  }

  def delete(key: K): Unit = {
    val i = index(key)
    val (remove, keep) = buckets(i).partition(_.key == key)
    if (remove.nonEmpty) {
      count = count - 1
    }
    buckets(i) = keep
  }

}
