import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MyDemoPage(),
    );
  }
}

class MyDemoPage extends StatefulWidget {
  @override
  _MyDemoPageState createState() => _MyDemoPageState();
}

class _MyDemoPageState extends State<MyDemoPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Keyboard Visibility Example'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('This demo uses KeyboardVisibilityProvider.'),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Input box for keyboard test',
                  ),
                ),
                Container(height: 60.0),
                Text(
                  'The keyboard is: ${KeyboardVisibilityProvider.isKeyboardVisible(context) ? 'VISIBLE' : 'NOT VISIBLE'}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
