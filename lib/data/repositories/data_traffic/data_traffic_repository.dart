import 'dart:async';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

class DataTrafficRepository {
  final BehaviorSubject<int> _subject = BehaviorSubject<int>.seeded(0);
  Timer? _timer;
  int _count = 0;
  final _log = Logger('DataTrafficRepository');
  Stream<int> get trafficStream => _subject.stream;

  int get lastValue => _subject.value;

  void start() {
    if (_timer != null) return; // already running

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _count++;
      if (!_subject.isClosed) {
        _subject.add(_count);
      }
    });
  }

  void pause() {
    _timer?.cancel();
    _timer = null;
  }

  void reset() {
    pause();
    _count = 0;
    if (!_subject.isClosed) {
      _subject.add(_count);
    }
  }

  void dispose() {
    _log.warning("DISPOSE DATA TRAFFIC REPOSITORY");
    _timer?.cancel();
    _timer = null;
    _subject.close();
  }
}
