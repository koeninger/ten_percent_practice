package sandbox.ch11

trait KeyValueStore[F[_,_]] {
  def put[K, V](f: F[K, V])(k: K, v: V): F[K, V]

  def get[K, V](f: F[K, V])(k: K): Option[V]

  def getOrElse[K, V](f: F[K, V])(k: K, default: V): V =
    get(f)(k).getOrElse(default)

  def values[K, V](f: F[K, V]): List[V]
}

object KeyValueStore {
  implicit val mapKeyValueStore: KeyValueStore[Map] = new KeyValueStore[Map] {
    def put[K, V](f: Map[K, V])(k: K, v: V): Map[K, V] =
      f + (k -> v)

    def get[K, V](f: Map[K, V])(k: K): Option[V] =
      f.get(k)

    def values[K, V](f: Map[K, V]): List[V] =
      f.values.toList
  }
}
