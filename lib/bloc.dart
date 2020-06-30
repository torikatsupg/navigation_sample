import 'dart:async';

import 'package:flutter/cupertino.dart';

class Bloc {
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

class BlocProvider extends InheritedWidget {
  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  Bloc get bloc => Bloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static BlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>();
  }
}
