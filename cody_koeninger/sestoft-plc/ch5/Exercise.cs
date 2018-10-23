namespace Exercise {

  public static class Ch5 {
    public static int[] Merge(int[] xs, int[] ys) {
      List<int> r = new List<int>();
      IEnumerator<int> xe = xs.AsEnumerable().GetEnumerator();
      IEnumerator<int> ye = ys.AsEnumerable().GetEnumerator();
      var x = xe.MoveNext();
      var y = ye.MoveNext();
      while (x || y) {
        if (x && y) {
          if (xe.Current < ye.Current) {
            r.Add(xe.Current);
            x = xe.MoveNext();
          } else {
            r.Add(ye.Current);
            y = ye.MoveNext();
          }
        } else if (x) {
          r.Add(xe.Current);
          x = xe.MoveNext();
        } else {
          r.Add(ye.Current);
          y = ye.MoveNext();
        }
      }
      return r.ToArray();
    }
  }

}