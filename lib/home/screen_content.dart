import 'package:flutter/material.dart';

class ScreenContent extends StatelessWidget {
  const ScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Front')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('🎄', style: TextStyle(fontSize: 200)),
            SizedBox(height: 50),
            Text('My Content Page !'),
          ],
        ),
      ),
    );
  }
}
