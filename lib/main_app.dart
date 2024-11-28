import 'package:flutter/material.dart';
import 'package:flutter_auth/auth/screen_front.dart';
import 'package:flutter_auth/auth/screen_sign_in.dart';
import 'package:flutter_auth/home/screen_content.dart';
import 'package:flutter_auth/home/screen_home.dart';
import 'package:flutter_auth/home/screen_me.dart';
import 'package:flutter_auth/home/screen_shell.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_auth/global.dart';
import 'package:flutter_auth/model/user_bloc.dart';
import 'package:flutter_auth/model/user_state.dart';
import 'package:flutter_auth/model/user_event.dart';

final userBloc = UserBloc();

final GoRouter router = GoRouter(
  navigatorKey: globalRouteKey,
  initialLocation: '/',
  routes: [
    // === sign up and sign in sections that does not require user to sign in first
    GoRoute(path: '/', pageBuilder: (ct, st) => NoTransitionPage(child: const SafeArea(child: ScreenFront()))),
    GoRoute(path: '/sign_in', pageBuilder: (ct, st) => NoTransitionPage(child: const SafeArea(child: ScreenSignIn()))),

    // === member only section
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return ScreenShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => NoTransitionPage(child: const SafeArea(child: ScreenHome())),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/my_content',
              pageBuilder: (context, state) => NoTransitionPage(child: const SafeArea(child: ScreenContent())),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/me',
              pageBuilder: (context, state) => NoTransitionPage(child: const SafeArea(child: ScreenMe())),
            ),
          ],
        ),
      ],
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    // print('user signed: ${userBloc.state.isSignedIn} | current route : ${state.fullPath}');
    List<String> guestOkPages = ['/', '/sign_in'];
    //=== if not signed in and is not in the guestOkPages, redirect to sign in page
    if ((!userBloc.state.isSignedIn) && (!guestOkPages.contains(state.fullPath))) {
      return '/';
    }
    //=== if user already signed in and is on guest or sign in page, redirect them to member /me page
    List<String> redirectHomePages = ['/', '/sign_in'];
    if ((userBloc.state.isSignedIn) && (redirectHomePages.contains(state.fullPath))) {
      return '/me';
    }
  },
  //trigger a rebuild of the router when the value of the Listenable changes.
  //useful for state change (like authentication status, user preferences, etc.) to update route accordingly
  refreshListenable: userBloc,
);

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    //=== hygrated bloc setup, load existing state if presented
    userBloc.hydrate();
    initSetup();
  }

  Future<void> initSetup() async {
    //=== any initial setup that needs to wait
    //await Future.delayed(Duration(seconds: 1));
    //=== after any initial setup, call inital user checked event to display screen accordingly
    userBloc.add(InitUserCheckedEvt());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<UserBloc>(create: (BuildContext context) => userBloc)],
      child: _AppBody(),
    );
  }
}

class _AppBody extends StatefulWidget {
  const _AppBody({super.key});
  @override
  State<_AppBody> createState() => __AppBodyState();
}

class __AppBodyState extends State<_AppBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(buildWhen: (previous, current) {
      //=== called only when initChecked state changed
      return current.initChecked != previous.initChecked;
    }, builder: (context, state) {
      if (state.initChecked == false) {
        //=== display empty container before initial setup is finished
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Text('initial setup.. ${context.read<UserBloc>().state.initChecked}'),
            ),
          ),
        );
      } else {
        //=== when initial setup is ready show main app
        return MaterialApp.router(
          scaffoldMessengerKey: globalSnackBarKey,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: 'flutter authentication demo',
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(brightness: Brightness.dark),
        );
      }
    });
  }
}
