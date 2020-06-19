import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _keyboardState;

  @override
  void initState() {
    super.initState();
    _keyboardState = KeyboardVisibility.isVisible;
    KeyboardVisibility.onChange.listen((bool visible) {
      setState(() {
        _keyboardState = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: MaterialApp(
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
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Input box for keyboard test',
                    ),
                  ),
                  Container(height: 60.0),
                  Text(
                    'The keyboard is: ${_keyboardState ? 'VISIBLE' : 'NOT VISIBLE'}',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
