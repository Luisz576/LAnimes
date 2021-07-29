import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:lanimes/blocs/UserBloc.dart';
import 'package:lanimes/models/User.dart';
import 'package:lanimes/services/api.dart';
import 'package:lanimes/services/database.dart';
import 'package:lanimes/utils/connection_result.dart';

class LoginScreen extends StatefulWidget {
  final PageController _pageController;

  LoginScreen(this._pageController);

  @override
  _LoginScreenState createState() => _LoginScreenState(_pageController);
}

class _LoginScreenState extends State<LoginScreen> {
  final PageController _pageController; //TODO: ?????? bloc como controlador
  final Database database = Database();
  final Api api = Api();

  _LoginScreenState(this._pageController);

  bool lembrarLogin = true;
  
  @override
  Widget build(BuildContext context) {
    database.getUser().then((user){
      if(!user.isEmpty()){
        _executeLoginWithToken(user.username, user.token, lembrarse: true).then((user){
          if(user != null)
            if(!user.isEmpty()){
              BlocProvider.of<UserBloc>(context).changeUser(user);
              //TODO: Redirecionar page, ou usar bloc para se autoredirecionar
            }
        });
      }
    });
    
    //LoginScreen
    return Container(
      
    );
  }

  Future<User?> _executeLoginWithPassword(String username, String password, { bool lembrarse = false }) async{
    final response = await api.loginWithUsernameAndPassword(username, password);
    if(response.status == ConnectionResult.SUCCESS){
      User user = User.fromMap(response.data);
      if(lembrarse) database.saveUser(user);
      return user;
    }
    return null;
  }

  Future<User?> _executeLoginWithToken(String username, String token, { bool lembrarse = false }) async{
    final response = await api.loginWithUsernameAndToken(username, token);
    if(response.status == ConnectionResult.SUCCESS){
      User user = User.fromMap(response.data);
      if(lembrarse) database.saveUser(user);
      return user;
    }
    return null;
  }
}