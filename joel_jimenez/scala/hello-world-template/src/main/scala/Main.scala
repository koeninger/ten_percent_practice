// Chapter 4
object Main extends App {

  val closure = (x: Int) => x * 5;
  println(closure(10));

  val closure2 = List(1, 2, 3, 4, 5).map(i => i * 2);
  println(closure2);

  val radlist = List(10, 20, 30, 40, 50);
  val circles = radlist.map(i => i * 10);
  println(circles);

  (1 to 50).
    toList.map(x => x * 5).
    filter(x => x % 5 == 0).
    foreach(println);
}
