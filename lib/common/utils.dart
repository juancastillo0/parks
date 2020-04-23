import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'utils.freezed.dart';

class Interval<T extends Comparable> {
  T min;
  T max;
  Interval(this.min, this.max);

  Interval update(T val) {
    if (val.compareTo(max) > 0) {
      max = val;
    }
    if (val.compareTo(min) < 0) {
      min = val;
    }
    return this;
  }

  Interval<T> fromIter(Iterable<T> iter) {
    return iter.fold(this, (prev, elem) => prev.update(elem));
  }
}

String currencyString(int cost) {
  if (cost == null) return "0";

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

@freezed
abstract class Result<T> implements _$Result<T> {
  const Result._();
  const factory Result(T value) = _Data<T>;
  const factory Result.err(String message) = _Error<T>;

  Result<K> mapOk<K>(Result<K> Function(T) f) {
    return this.when(f, err: (err) => Result.err(err));
  }

  T okOrNull() {
    return this.when((v) => v, err: (err) => null);
  }
}

@freezed
abstract class RequestState implements _$RequestState {
  const RequestState._();
  const factory RequestState.err(String message) = _Err;
  const factory RequestState.loading() = _Loading;
  const factory RequestState.none() = _None;

  Widget asWidget() => this.when(
      err: (err) => Text(err),
      loading: () => CircularProgressIndicator(),
      none: () => Container(width: 0, height: 0));
}
