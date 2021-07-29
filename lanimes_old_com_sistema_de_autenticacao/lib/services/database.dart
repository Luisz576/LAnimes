import 'package:lanimes/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database{

  final String _usernameCamp = "user_username";
  final String _tokenCamp = "user_token";
  final String _genresCamp = "user_genres";
  final String _favoritesCamp = "user_favorites";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> saveUser(User user) async {
    SharedPreferences prefs = await _prefs;
    if(!user.isEmpty()){
      await prefs.setString(_usernameCamp, user.username);
      await prefs.setString(_tokenCamp, user.token);
      await prefs.setStringList(_genresCamp, user.genres);
      await prefs.setStringList(_favoritesCamp, user.favorites);
      return true;
    }
    return false;
  }

  Future<User> getUser() async{
    SharedPreferences prefs = await _prefs;
    final username = prefs.getString(_usernameCamp);
    final token = prefs.getString(_tokenCamp);
    final genres = prefs.getStringList(_genresCamp);
    final favorites = prefs.getStringList(_favoritesCamp);
    return User(username, token, genres, favorites);
  }

}