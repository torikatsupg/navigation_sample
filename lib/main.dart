import 'package:blocsample/bloc.dart';
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
      home: Screens(),
    );
  }
}

class Screens extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScreensState();
}

class ScreensState extends State<Screens> {
  Bloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Bloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _bloc.onAdd,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Stream Test'),
          ),
          body: Text(snapshot?.data.toString()),
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
            onTap: (index) => _onTap(index),
          ),
        );
      },
    );
  }

  void _onTap(int index) {
    _bloc.pick(index);
  }
}

