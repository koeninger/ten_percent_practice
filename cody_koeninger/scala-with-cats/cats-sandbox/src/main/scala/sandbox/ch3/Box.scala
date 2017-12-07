package sandbox.ch3

final case class Box[A](value: A)

object Box {
  implicit def boxPrintable[A](implicit ev: Printable[A]): Printable[Box[A]] = ev.contramap(_.value)

  implicit def boxCodec[A](implicit ev: Codec[A]): Codec[Box[A]] =
    ev.imap(Box.apply, _.value)
}
