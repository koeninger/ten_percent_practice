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

// package com {
//   package oreilly {
//     class Config(val baseUrl: String = "http://localhost")
//   }
// }

// val url = new com.oreilly.Config().baseUrl

class User { protected val passwd = scala.util.Random.nextString(10) }
class ValidUser extends User { def isValid = ! passwd.isEmpty }
val isValid = new ValidUser().isValid

class User(private var password: String) {
  def update(p: String) {
    println("Modifying the password!")
    password = p
  }
  def validate(p: String) = p == password
}
val u = new User("1234")
val isValid = u.validate("4567")
u.update("4567")
val isValid = u.validate("4567"
)

// :past -raw
// package com.oreilly {
//   private[oreilly] class Config {
//     val url = "http://localhost"
//   }

//   class Authentication {
//     private[this] val password = "jason"
//     def validate = password.size > 0
//   }

//   class Test {
//     println(s"url = ${new Config().url}")
//   }
// }

val valid = new com.oreilly.Authentication().validate
new com.oreilly.Test
