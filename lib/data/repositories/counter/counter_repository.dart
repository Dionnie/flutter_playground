import 'package:flutter/foundation.dart';
import 'package:flutter_playground/utils/result.dart';

class FakeCounterRepository extends ChangeNotifier {
  Stream<Result<int>> getCounterStream() {
    return Stream.periodic(
      const Duration(seconds: 1),
      (count) => Result.ok(count),
    ).take(500);
  }
}
