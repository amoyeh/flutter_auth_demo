import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_auth/model/user_state.dart';
import 'package:flutter_auth/model/user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> with HydratedMixin, ChangeNotifier {
  UserBloc() : super(const UserState()) {
    on<UserSignInAfterEvt>(callUserSignIn);
    on<UserSignOutEvt>(callUserSignOut);
    on<InitUserCheckedEvt>(callInitUserChecked);
  }

  @override
  //called at launch when BlocUser is initiated in app_main router refreshListenable
  UserState fromJson(Map<String, dynamic> json) {
    // fromJson is automatically called when constructed from HydratedBloc
    // APITool().userToken = json['token'];
    return UserState.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(UserState state) {
    return state.toJson();
  }

  void callInitUserChecked(InitUserCheckedEvt event, emitter) async {
    emitter(state.copyWith(initChecked: true));
  }

  void callUserSignIn(UserSignInAfterEvt event, emitter) async {
    emitter(state.copyWith(isSignedIn: true, userInfo: event.userInfo, token: event.token));
    //== trigger go_router class to update routing state, (in router's refreshListenable setting)
    notifyListeners();
  }

  void callUserSignOut(event, emitter) async {
    emitter(state.copyWith(isSignedIn: false, token: ''));
    await HydratedBloc.storage.clear();
    notifyListeners();
  }
}
