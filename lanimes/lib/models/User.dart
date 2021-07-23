class User{

  late String username;
  late String token;
  late List<String> genres, favorites;

  User(this.username, this.token, this.genres, this.favorites);

  User.fromMap(Map map){
    username = map["user_id"];
    token = map["token"];
    genres = map["genres"];
    favorites = map["favorites"];
  }

  User.fromMapAndToken(Map map, _token){
    username = map["user_id"];
    token = _token;
    genres = map["genres"];
    favorites = map["favorites"];
  }

  String getGenresLikeString(){
    return this.genres.join(',');
  }

}