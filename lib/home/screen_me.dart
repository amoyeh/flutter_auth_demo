import 'package:flutter/material.dart';
import 'package:flutter_auth/model/user_bloc.dart';
import 'package:flutter_auth/model/user_event.dart';
import 'package:flutter_auth/model/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenMe extends StatelessWidget {
  const ScreenMe({super.key});

  @override
  Widget build(BuildContext context) {
    UserState userState = context.read<UserBloc>().state;
    return Scaffold(
      appBar: AppBar(title: const Text('Front')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('user state information', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('email : ${userState.userInfo.email}'),
            Text('name : ${userState.userInfo.name}'),
            Text('token: ${userState.token}'),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                context.read<UserBloc>().add(UserSignOutEvt());
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
