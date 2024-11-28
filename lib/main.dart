import 'package:flutter/material.dart';
import 'package:flutter_auth/main_app.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  //=== Hydratedbloc setup
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  );
  runApp(const MainApp());
}


/*

This is a minimal Flutter project setup with the following features:

BLoC to manage global member state
Hydrated_BLoC to persist member state (states are saved in platform-specific storage)
go_router to handle route management
StatefulShellRoute to maintain a bottom navigation bar across different pages
Integration of BLoC with go_router to redirect users to member-only or guest-only pages based on state changes
This project is an excellent starting point for a Flutter application that requires users to sign in to access member-only pages.

And cheers ! 🍺

*/