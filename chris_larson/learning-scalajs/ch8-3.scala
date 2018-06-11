val d = new java.util.Date
import java.util.Date
val d= new Date
println("Ypur new UUID is " + {import java.util.UUID; UUID.randomUUID})
import java.util
val d = new util.Date
import collection.mutable._
val b = new ArrayBuffer[String]
b += "HEllo"
val q = new Queue[Int]
q.enqueue(3, 4, 5)
val pop = q.dequeue
println(q)

import collection.mutable.{Queue, ArrayBuffer}
val q = new Queue[Int]
val b = new ArrayBuffer[String]
val m = Map(1 -> 2)

import collection.mutable.{Map=>MutMap}
val m1 = Map(1 -> 2)
val m2 = MutMap(2 -> 3)
m2.remove(2); println(m2)
