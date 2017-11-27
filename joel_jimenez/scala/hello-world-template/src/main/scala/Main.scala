// Chapter 3
object Main extends App {

  println( circles(5) )
  pyramid(5)

  def circles(n: Int): String = {
    println("Circle(" + n * 50 + ")")
    if(n == 1){
      return "DONE"
    } else{
      circles(n-1)
    }
  }

  def pyramid(n: Int): String = {
    println("*" * n)
    if(n == 1){
      return "DONE"
    } else{
      pyramid(n-1)
    }
  }

}
