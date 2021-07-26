import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myroom/Business/managers/fb_manager.dart';
import 'package:myroom/Entities/user_info.dart';

final UserDataBloc blocUserData = UserDataBloc();

class UserDataBloc {
  StreamController<UserInfo> _streamUserInfo;
  StreamSubscription<Event> _streamSub;
  UserInfo _userInfo;

  UserDataBloc() {
    _userInfo = UserInfo();
  }

  Stream<UserInfo> get getStreamUserInfo => _streamUserInfo.stream;
  UserInfo get getUserInfo => _userInfo;
  set setUserInfo(UserInfo userInfo) {
    _userInfo = userInfo;
    if (_streamUserInfo == null || _streamUserInfo.isClosed) {
      _streamUserInfo = StreamController<UserInfo>.broadcast();
      buildStreamUserData();
    }
  }

  void updateWidgetUserInfo() => _streamUserInfo.sink.add(getUserInfo);

  buildStreamUserData() {
    _streamSub =
        fbManager.userData.ref.child(_userInfo.key).onValue.listen((event) {
      setUserInfo = UserInfo.fromMap(event.snapshot.value as Map);
      print(getUserInfo.toMap());
      updateWidgetUserInfo();
    });
    return SizedBox();
  }

  Future dispose() async {
    _userInfo = null;
    await _streamSub?.cancel();
    await _streamUserInfo.close();
  }
}
