import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:lanimes/models/User.dart';

class UserBloc extends BlocBase{

  final StreamController<User?> _userController = StreamController<User?>();
  Stream get outUser => _userController.stream;

  User? _user;
  User? get currentUser => _user;

  void changeUser(User? user){
    _user = null;
    if(user != null)
      if(!user.isEmpty())
        _user = user;
    _userController.sink.add(_user);
  }

  void dispose() {
    _userController.close();
  }

}