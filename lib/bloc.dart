import 'dart:async';

import 'package:flutter/cupertino.dart';

class Bloc {
  Bloc() {
    print('bloc is created');
  }
  final _inputController = StreamController<int>();
  final _outputController = StreamController<int>();


  Function(int) get add => _inputController.sink.add;
  Stream get onAdd => _outputController.stream;

  void pick(int index) {
    print('pick $index');
    _outputController.sink.add(index);
  }

  void dispose() {
    _inputController.close();
    _outputController.close();
  }
}

