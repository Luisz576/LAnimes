import 'package:lanimes/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database{

  final String _usernameCamp = "user_username";
  final String _tokenCamp = "user_token";
  final String _genresCamp = "user_genres";
  final String _favoritesCamp = "user_favorites";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveUser(User user) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(_usernameCamp, user.username);
    await prefs.setString(_tokenCamp, user.token);
    await prefs.setStringList(_genresCamp, user.genres);
    await prefs.setStringList(_favoritesCamp, user.favorites);
  }

  Future<User> getUser() async{
    SharedPreferences prefs = await _prefs;
    final username = prefs.getString(_usernameCamp);
    final token = prefs.getString(_tokenCamp);
    final genres = prefs.getStringList(_genresCamp);
    final favorites = prefs.getStringList(_favoritesCamp);
    return User(username!, token!, genres!, favorites!);
  }

}