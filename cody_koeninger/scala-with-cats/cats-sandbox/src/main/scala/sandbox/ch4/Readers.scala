package sandbox.ch4

import cats.data.Reader

case class Db(
  usernames: Map[Int, String],
  passwords: Map[String, String]
)

object Db {
  type DbReader[A] = Reader[Db, A]

  def findUsername(userId: Int): DbReader[Option[String]] =
    Reader(db => db.usernames.get(userId))

  def checkPassword(username: String, password: String): DbReader[Boolean] =
    Reader(db => db.passwords.get(username).map(_ == password).getOrElse(false))

  def checkLogin(userId: Int, password: String): DbReader[Boolean] =
    for {
      name <- findUsername(userId)
      ok <- {
        // would look cleaner with false.pure[DbReader]
        name.map(n => checkPassword(n, password)).
          getOrElse(Reader((_: Db) => false))

      }
    } yield {
      ok
    }
}
