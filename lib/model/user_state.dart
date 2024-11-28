import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String email;
  final String name;
  const UserInfo({this.email = '', this.name = ''});
  @override
  List<Object?> get props => [email, name];
  Map<String, dynamic> toJson() {
    return {'email': email, 'name': name};
  }

  static fromJson(jsonObj) {
    return UserInfo(email: jsonObj['email'], name: jsonObj['name']);
  }
}

class UserState extends Equatable {
  final bool initChecked;
  final bool isSignedIn;
  final String token;
  final UserInfo userInfo;
  const UserState({
    this.initChecked = false,
    this.isSignedIn = false,
    this.token = '',
    this.userInfo = const UserInfo(),
  });
  @override
  List<Object?> get props => [initChecked, isSignedIn, token, userInfo];
  UserState copyWith({
    bool? initChecked,
    bool? isSignedIn,
    String? token,
    int? exp,
    UserInfo? userInfo,
  }) {
    return UserState(
      initChecked: initChecked ?? this.initChecked,
      isSignedIn: isSignedIn ?? this.isSignedIn,
      token: token ?? this.token,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  Map<String, dynamic> toJson() {
    //== for HydratedMixin Bloc : store following data
    return {'isSignedIn': isSignedIn, 'token': token, 'userInfo': userInfo.toJson()};
  }

  static fromJson(jsonObj) {
    //== for HydratedMixin Bloc : load from stored data
    return UserState(
      isSignedIn: jsonObj['isSignedIn'] as bool,
      token: jsonObj['token'],
      userInfo: UserInfo.fromJson(jsonObj['userInfo']),
    );
  }
}
