import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_playground/data/repositories/data_traffic/data_traffic_repository.dart';

class ShopViewModel extends ChangeNotifier {
  final DataTrafficRepository _repo;
  late final StreamSubscription<int> _subscription;

  int _currentCount = 0;
  bool _isRunning = false;

  int get currentCount => _currentCount;
  bool get isRunning => _isRunning;

  ShopViewModel({required DataTrafficRepository dataTrafficRepository})
    : _repo = dataTrafficRepository {
    // Subscribe to stream and update state
    _subscription = _repo.trafficStream.listen((value) {
      _currentCount = value;
      notifyListeners();
    });
  }

  void start() {
    _repo.start();
    _isRunning = true;
    notifyListeners();
  }

  void pause() {
    _repo.pause();
    _isRunning = false;
    notifyListeners();
  }

  void reset() {
    _repo.reset();
    _isRunning = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _repo.dispose();
    super.dispose();
  }
}
