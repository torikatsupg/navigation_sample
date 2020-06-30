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
    final bloc = BlocProvider.of(context).bloc;
    return StreamBuilder<int>(
      stream: bloc.onAdd,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Stream Test')
          ),
          body: _screens(snapshot.data),
          bottomNavigationBar: BottomNavigationBar(
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
            onTap: (index) => _onTap(bloc, index),
          ),
        );
      },
    );
  }
  
  Widget _screens(int index) {
    switch(index) {
      case 0: return ScreenA();
      case 1: return ScreenB();
      case 2: return ScreenC();
      default: return Text('null');
    }
  }

  void _onTap(Bloc bloc, int index) {
    bloc.pick(index);
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
