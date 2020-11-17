import 'package:flutter/material.dart';
import 'package:proto_flutter_kerahbiru/app.dart';
import 'package:proto_flutter_kerahbiru/services/web_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    App(profileRepository: WebClient())
    // MyApp()
  );


}


class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  MaterialColor _color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello Rectangle',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Rectangle'),
        ),
        body: Column(children: <Widget>[
          HelloRectangle(_color),
          FlatButton(
            child: Text(
              _color == Colors.green ? "Turn Blue" : "Turn Green",
              style: TextStyle(fontSize: 40.0),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              setState(() {
                _color = _color == Colors.green ? Colors.blue : Colors.green;
              });
            },
          ),
        ]),
      ),
    );
  }
}

class HelloRectangle extends StatefulWidget {
  final Color color;

  HelloRectangle(this.color);

  @override
  HelloRectangleState createState() {
    return new HelloRectangleState();
  }
}

class HelloRectangleState extends State<HelloRectangle> {
  HelloRectangleState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: widget.color,
        height: 400.0,
        width: 300.0,
      ),
    );
  }
}