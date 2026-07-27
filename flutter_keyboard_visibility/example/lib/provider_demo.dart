import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ProviderDemo extends StatelessWidget {
  const ProviderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const KeyboardVisibilityProvider(child: MyDemoPage());
  }
}

class MyDemoPage extends StatelessWidget {
  const MyDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Keyboard Visibility Provider')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('This demo uses KeyboardVisibilityProvider.'),
              Container(height: 60.0),
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
    );
  }
}
