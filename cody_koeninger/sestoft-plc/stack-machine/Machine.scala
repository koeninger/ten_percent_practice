import scala.io.Source

object Machine {
  val Cst = 0
  val Var = 1
  val Add = 2
  val Sub = 3
  val Mul = 4
  val Pop = 5
  val Swap = 6

  def seval(code: Array[Int]): Int = {
    val stack = new Array[Int](1000)
    // stack pointer
    var sp = -1
    // program counter
    var pc = 0
    // current instruction
    var instr = -1
    while (pc < code.length) {
      instr = code(pc)
      pc += 1
      instr match {
        case Cst =>
          stack(sp + 1) = code(pc)
          pc += 1
          sp += 1
        case Var =>
          stack(sp + 1) = stack(sp - code(pc))
          pc += 1
          sp += 1
        case Add =>
          stack(sp - 1) = stack(sp - 1) + stack(sp)
          sp -= 1
        case Sub =>
          stack(sp - 1) = stack(sp - 1) - stack(sp)
          sp -= 1
        case Mul =>
          stack(sp - 1) = stack(sp - 1) * stack(sp)
          sp -= 1
        case Pop =>
          sp -= 1
        case Swap =>
          val tmp = stack(sp)
          stack(sp) = stack(sp - 1)
          stack(sp - 1) = tmp
        case _ => throw new Exception(s"Unknown intruction $instr")
      }
    }
    stack(sp)
  }

  def main(args: Array[String]): Unit = {
    if (args.length == 1) {
      val code = Source.fromFile(args(0)).
        getLines.
        flatMap(_.split("""\s+""")).
        map(_.toInt).
        toArray

      println(seval(code))
    } else {
      System.err.println("Expected a filename to read byte instructions from")
    }
  }
}
