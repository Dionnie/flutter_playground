import 'package:flutter/foundation.dart';
import 'package:flutter_playground/data/repositories/counter/counter_repository.dart';
import 'package:flutter_playground/utils/command_stream.dart';

class ShopViewModel extends ChangeNotifier {
  ShopViewModel({required FakeCounterRepository repo}) : _repo = repo {
    counter = CommandStream0<int>(_repo.getCounterStream);
  }

  final FakeCounterRepository _repo;
  late final CommandStream0<int> counter;
}
