import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard visibility example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KeyboardVisibilityExample(),
    );
  }
}

class KeyboardVisibilityExample extends StatefulWidget {
  KeyboardVisibilityExample({Key key}) : super(key: key);


  @override
  _KeyboardVisibilityExampleState createState() => _KeyboardVisibilityExampleState();
}

class _KeyboardVisibilityExampleState extends State<KeyboardVisibilityExample> {

  KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;
  bool _keyboardState;

  @protected
  void initState() {
    super.initState();

    _keyboardState = _keyboardVisibility.isKeyboardVisible;

    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
      onChange: (bool visible) {
        setState(() {
          _keyboardState = visible;
        });
      },
    );
  }

  @override
  void dispose() {
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keyboard visibility example'),
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
                'The current state of the keyboard is: ' + (_keyboardState ? 'VISIBLE' : 'NOT VISIBLE'),
              ),
            ],
          )
        ),
      ),
    );
  }
}
