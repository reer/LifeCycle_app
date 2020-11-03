import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //#1
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState;

  @override
  //#1, #3_didChangeAppLifecycleStateからの再開,
  //inactiveからアプリに戻ってくると通る
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //#2(端末戻るボタン),　#3_didChangeAppLifecycleStateから戻ってきた時Resumeとして入る
  //アプリから一旦落とすことなく離脱するとinactiveに入る
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
      print('State = $_appLifecycleState');
    });
  }

  //#1
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new Scaffold(body: new OrientationBuilder(
      builder: (context, orientation) {
        return new Center(
          child: new Text(
            _appLifecycleState.toString(),
            style: new TextStyle(
                fontSize: 20.0,
                color: orientation == Orientation.portrait
                    ? Colors.blue
                    : Colors.orange),
          ),
        );
      },
    )));
  }
}
