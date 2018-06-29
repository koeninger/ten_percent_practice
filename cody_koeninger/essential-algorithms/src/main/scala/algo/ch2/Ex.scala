package algo.ch2

import scala.annotation.tailrec
import scala.util.Random
import java.util.BitSet

object Ex {
  trait Die {
    def sides: Int
    def apply(): Int
  }

  class FairDie(val sides: Int) extends Die {
    private val rng = new Random
    def apply(): Int = 1 + rng.nextInt(sides)
  }

  class BiasedDie(val sides: Int) extends Die {
    private val rng = new Random
    private val bias = 1.2
    def apply(): Int = Math.min(sides, 1 + ((rng.nextInt(sides * 10) * bias) / 10).toInt)
  }

  /* true for heads, false for tails */
  def coinFlip(d: Die): Boolean = {
    require(d.sides % 2 == 0, "expected even die")
    d() > (d.sides / 2)
  }

  @tailrec
  def fairCoinFlip(d: Die): Boolean = {
    (coinFlip(d), coinFlip(d)) match {
      case (true, false) => true
      case (false, true) => false
      case _ => fairCoinFlip(d)
    }
  }

  def log2(n: Int): Int =
    Math.ceil(Math.log(n) / Math.log(2)).toInt

  def fairFromBiased(d: Die): Int = {
    val bits = log2(d.sides)
    val bs = new BitSet(bits)
    while (bs.toLongArray.isEmpty || bs.toLongArray()(0) > d.sides) {
      bs.clear()
      (0 until bits).foreach { i =>
        if (fairCoinFlip(d)) {
          bs.set(i)
        }
      }
    }
    bs.toLongArray()(0).toInt
  }

  /* destructively randomize array up to the first n items */
  def shuffle[T](a: Array[T], n: Int): Unit = {
    val rng = new Random
    (0 until n - 1).foreach { i =>
      val j = rng.nextInt(a.size - i)
      val tmp = a(i)
      a(i) = a(j)
      a(j) = tmp
    }
  }

  /* destructively randomize the whole array */
  def shuffle[T](a: Array[T]): Unit = {
    shuffle(a, a.size)
  }

  def pickN[T](a: Array[T], n: Int): Array[T] = {
    require(n <= a.size, "array is too small")
    val s = a.clone
    shuffle(s, n)
    s.slice(0, n)
  }

  case class Card(suit: String, rank: String)

  object Card {
    val suits = "Spades,Hearts,Clubs,Diamonds".split(",")
    val ranks = "Ace,2,3,4,5,6,7,8,9,10,Jack,Queen,King".split(",")

    def deck(): Array[Card] = {
      val deck = new Array[Card](52)
      var i = 0
      suits.foreach { s =>
        ranks.foreach { r =>
          deck(i) = Card(s, r)
          i += 1
        }
      }
      deck
    }

    def deal(players: Int, hand: Int): Array[Array[Card]] = {
      val d = deck()
      val c = players * hand
      pickN(d, c).grouped(hand).toArray
    }
  }

  def greatestCommonDivisor(x: Int, y: Int): Int = {
    var a = x
    var b = y
    while (b != 0) {
      val rem = a % b
      a = b
      b = rem
    }

    a
  }

  def leastCommonMultiple(x: Int, y: Int): Int = {
    val gcd = greatestCommonDivisor(x, y)
    val bigger = Math.max(x, y)
    val smaller = Math.min(x, y)
    bigger * (smaller / gcd)
  }

}
