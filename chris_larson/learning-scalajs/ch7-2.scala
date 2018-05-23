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
