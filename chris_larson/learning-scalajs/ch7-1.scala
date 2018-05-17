val m = Map("AAPL" -> 597, "MSFT" -> 40)
val n = m - "AAPL" + ("GOOG" -> 521)
println(m)

val nums = collection.mutable.Buffer(1)
for (i <- 2 to 10) nums += i
println(nums)
val nums = collection.mutable.Buffer[Int]()
for (i <- 1 to 10) nums += i 
println(nums)
val l = nums.toList

val m =Map("AAPL" -> 597, "MSFT" -> 40)
val b = m.toBuffer
b trimStart 1
b += ("GOOG" -> 521)
val n = b.toMap
b += ("GOOG" -> 521)
val l = b.toList
val s = b.toSet
