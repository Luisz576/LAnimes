class User{

  late String username;
  late String token;
  late List<String> genres, favorites;

  User(username, token, genres, favorites){
    this.username = username != null ? username : '';
    this.token = token != null ? token : '';
    this.genres = genres != null ? genres : [];
    this.favorites = favorites != null ? favorites : [];
  }

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

  bool isEmpty(){
    return username == '' || token == '';
  }

}