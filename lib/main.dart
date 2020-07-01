import 'package:blocsample/bloc.dart';
import 'package:blocsample/screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
          child: Screens(),
      ),
    );
  }
}

class Screens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Test'),
      ),
      body: _Screen(),
      bottomNavigationBar: _Navigation(),
    );
  }
}

class _Screen extends StatelessWidget {
  const _Screen({Key key}) : super();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).bloc;
    return StreamBuilder<int>(
      stream: bloc.onAdd,
      builder: _screens,
    );
  }

  Widget _screens(BuildContext context, AsyncSnapshot<int> snapshot) {
    switch (snapshot.data) {
      case 0:
        return ScreenA();
      case 1:
        return ScreenB();
      case 2:
        return ScreenC();
      default:
        return Text('null');
    }
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).bloc;
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          title: Text('ScreenA'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          title: Text('ScreenB'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          title: Text('ScreenC'),
        ),
      ],
      onTap: (index) => _onTap(index, bloc),
    );
  }

  void _onTap(int index, Bloc bloc) {
    bloc.pick(index);
  }
}

class BlocProvider extends InheritedWidget {
  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  Bloc _bloc;
  Bloc get bloc  {
    if (_bloc == null) {
      _bloc = Bloc();
    }
    return _bloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static BlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>();
  }
}
