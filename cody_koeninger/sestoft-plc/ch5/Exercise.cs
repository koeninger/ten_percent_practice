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

  public static List<T> Merge<T>(IEnumerator<T> xe, IEnumerator<T> ye, IComparer<T> cmp) {
      List<T> r = new List<T>();
      var x = xe.MoveNext();
      var y = ye.MoveNext();
      while (x || y) {
        if (x && y) {
          if (cmp.Compare(xe.Current, ye.Current) < 0) {
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
      return r;
    }

  }

}