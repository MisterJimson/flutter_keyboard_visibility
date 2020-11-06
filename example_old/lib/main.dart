import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KeyboardDismissOnTap(
        child: Scaffold(
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
                  KeyboardVisibilityBuilder(builder: (context, visible) {
                    return Text(
                      'The keyboard is: ${visible ? 'VISIBLE' : 'NOT VISIBLE'}',
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
