import 'dart:async';
import 'package:flutter/foundation.dart';
import 'result.dart';

typedef StreamAction0<T> = Stream<Result<T>> Function();
typedef StreamAction1<T, A> = Stream<Result<T>> Function(A);

abstract class CommandStream<T> extends ChangeNotifier {
  CommandStream();

  bool _running = false;
  bool get running => _running;

  Result<T>? _latest;
  Result<T>? get latest => _latest;

  bool get completed => _latest is Ok<T>;
  bool get error => _latest is Error<T>;

  StreamSubscription<Result<T>>? _subscription;

  void clear() {
    _latest = null;
    notifyListeners();
  }

  void _start(Stream<Result<T>> stream) {
    if (_running) return;

    _running = true;
    _latest = null;
    notifyListeners();

    _subscription = stream.listen(
      (data) {
        _latest = data;
        notifyListeners();
      },
      onError: (err, stack) {
        // If the stream throws outside of Result.error, wrap it
        _latest = Result.error(
          err is Exception ? err : Exception(err.toString()),
        );
        _running = false;
        notifyListeners();
      },
      onDone: () {
        _running = false;
        notifyListeners();
      },
    );
  }

  void stop() {
    _subscription?.cancel();
    _running = false;
    notifyListeners();
  }
}

class CommandStream0<T> extends CommandStream<T> {
  CommandStream0(this._action);

  final StreamAction0<T> _action;

  void start() {
    _start(_action());
  }
}

class CommandStream1<T, A> extends CommandStream<T> {
  CommandStream1(this._action);

  final StreamAction1<T, A> _action;

  void start(A argument) {
    _start(_action(argument));
  }
}
