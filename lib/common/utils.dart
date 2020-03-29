class Interval<T extends Comparable> {
  T min;
  T max;
  Interval(this.min, this.max);

  Interval update(T val) {
    if (val.compareTo(max) > 0) {
      max = val;
    } else if (val.compareTo(min) < 0) {
      min = val;
    }
    return this;
  }

  Interval<T> fromIter(Iterable<T> iter) {
    // final first = iter.first;
    // final interval = Interval(first, first);
    return iter.fold(this, (prev, elem) => prev.update(elem));
  }
}

String currencyString(double cost) {
  var s = cost.toInt().toString();
  if (s.length <= 3) return s;

  final ans = [];
  var prev = 0;
  for (var i = s.length - (s.length % 3); i >= 0; i -= 3) {
    final size = s.length - i;
    ans.add(s.substring(prev, size));
    prev += size;
  }
  return ans.join(",");
}
