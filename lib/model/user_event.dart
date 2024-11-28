import 'package:flutter_auth/model/user_state.dart';

class UserEvent {
  const UserEvent();
}

class UserSignInAfterEvt extends UserEvent {
  static const evtName = 'UserSignInAfterEvent';
  late UserInfo userInfo;
  late String token;
  UserSignInAfterEvt(this.userInfo, this.token) : super();
}

class UserSignOutEvt extends UserEvent {
  static const evtName = 'UserSignOutEvent';
}

class InitUserCheckedEvt extends UserEvent {
  static const evtName = 'InitUserCheckEvt';
  InitUserCheckedEvt() : super();
}
