def nextOption = if (util.Random.nextInt > 0) Some(1) else None
val a = nextOption
val b = nextOption
nextOption.fold(-1)(x => x)
nextOption getOrElse 5
nextOption getOrElse {
  println("error!"); -1
}
nextOption orElse nextOption
nextOption match { case Some(x) => x; case None => -1}

throw new Exception("No DB connection, exiting...")
def loopAndFail(end: Int, failAt: Int): Int = {
  for (i <- 1 to end) {
    println(s"$i) ")
    if (i == failAt) throw new Exception("Too many iterations")
  }
  end
}
loopAndFail(10, 3)
val t1 = util.Try( loopAndFail(2, 3) )
val t2 = util.Try( loopAndFail(4, 2) )

def nextError = util.Try{ 1 / util.Random.nextInt(2) }
val x = nextError
val y = nextError

nextError flatMap { _ => nextError }
nextError foreach(x => println("success!" + x))
nextError getOrElse 0
nextError orElse nextError
nextError.toOption
nextError map (_ * 2)
nextError match { case util.Success(x) => x; case util.Failure(error) => -1 }
nextError

val input = "123"
val result = util.Try(input.toInt) orElse util.Try(input.trim.toInt)
result foreach { r => println(s"Parsed '$input' to $r!")}
val x = result match {
  case util.Success(x) => Some(x)
  case util.Failure(ex) => {
    println(s"Couldn't parse input '$input'")
    None
  }
}
