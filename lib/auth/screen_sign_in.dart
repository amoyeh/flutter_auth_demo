import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_auth/model/user_bloc.dart';
import 'package:flutter_auth/model/user_state.dart';
import 'package:flutter_auth/model/user_event.dart';

class ScreenSignIn extends StatelessWidget {
  const ScreenSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Sign In Content'),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                //=== sign in user with fake data
                dynamic userInfo = UserInfo(email: 'user@email.com', name: 'user name');
                context.read<UserBloc>().add(UserSignInAfterEvt(userInfo, 'ABCDE_AT_${DateTime.now()}'));
              },
              child: const Text('Process sign in with fake data'),
            ),
          ],
        ),
      ),
    );
  }
}
