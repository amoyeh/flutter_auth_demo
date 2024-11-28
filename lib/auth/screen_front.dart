import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenFront extends StatelessWidget {
  const ScreenFront({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Front')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Front Page Content'),
            SizedBox(height: 30),
            ElevatedButton(onPressed: () => context.go('/sign_in'), child: const Text('Go To Sign In')),
          ],
        ),
      ),
    );
  }
}
