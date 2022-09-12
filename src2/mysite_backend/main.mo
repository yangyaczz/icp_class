import Array "mo:base/Array";
import Int "mo:base/Int";

actor {
  func Quicksort(arr : [Int]) : [Int] {
      let n = arr.size();
      if (n < 2) {
          arr;
      } else {
          let result: [var Int] = Array.thaw(arr);
          QuicksortHelper(result, 0, n - 1);
          Array.freeze(result); 
      };
  };

  func QuicksortHelper(
      arr : [var Int],
      l : Int,
      r : Int
  ) {
      if (l < r) {
          var i = l;
          var j = r;
          var swap  = arr[0];
          let pivot = arr[Int.abs(l + r) / 2];
          while (i <= j) {
              while (arr[Int.abs(i)] < pivot) {
                  i := i + 1;
              };
              while (arr[Int.abs(j)] > pivot) {
                  j := j - 1;
              };
              if (i <= j) {
                  swap := arr[Int.abs(i)];
                  arr[Int.abs(i)] := arr[Int.abs(j)];
                  arr[Int.abs(j)] := swap;
                  i := i + 1;
                  j := j - 1;
              };
          };
          if (l < j) {
              QuicksortHelper(arr, l, j);
          };
          if (i < r) {
              QuicksortHelper(arr, i, r);
          };
      };
  };


  public func qsort(arr : [Int]) : async [Int] {
    Quicksort(arr);
  };

};