import 'package:lanimes/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database{
  static const String GENRES_CAMP = "user_genres";
  static const String FAVORITES_CAMP = "user_favorites";

  static Future<bool> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      await prefs.setStringList(GENRES_CAMP, user.genres);
      await prefs.setStringList(FAVORITES_CAMP, user.favorites);
      return true;
    }catch(e){
      return false;
    }
  }

  static Future<User> getUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final genres = prefs.getStringList(GENRES_CAMP);
    final favorites = prefs.getStringList(FAVORITES_CAMP);
    return User(genres, favorites);
  }

}