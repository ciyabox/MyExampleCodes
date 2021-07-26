import 'dart:async';

import 'package:myroom/Entities/avatar.dart';

final AvatarBloc blocAvatar = AvatarBloc();

class AvatarBloc {
  StreamController<Avatar> _streamAvatar;
  Avatar _avatar;

  AvatarBloc() {
    _avatar = Avatar();
  }

  Stream<Avatar> get getStreamAvatar => _streamAvatar.stream;
  Avatar get getAvatar => _avatar;
  set setAvatar(Avatar avatar) {
    _avatar = avatar;
    if (_streamAvatar == null || _streamAvatar.isClosed) {
      _streamAvatar = StreamController<Avatar>.broadcast();
    }
  }

  void updateWidgetAvatar() => _streamAvatar.sink.add(getAvatar);

  Future dispose() async {
    _avatar = Avatar();
    await _streamAvatar.close();
  }
}
