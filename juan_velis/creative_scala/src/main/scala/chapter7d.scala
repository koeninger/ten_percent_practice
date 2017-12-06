object Example {
    // 7.5 Reasoning recurson exercises

    def identity(n:Int):Int=
      n match {
        case 0 => 0
        case n => 1+identity(n-1)
      }

    def double(n: Int):Int=
      n match {
        case 0 => 0
        case n => 2+double(n-1)
      }

    def main(args: Array[String]): Unit = {
      println(identity(5))
      println(double(22))
    }
}