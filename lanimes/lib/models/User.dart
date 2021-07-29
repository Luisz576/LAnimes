class User{

  List<String> genres = [], favorites = [];

  User(genres, favorites){
    this.genres = genres != null ? genres : [];
    this.favorites = favorites != null ? favorites : [];
  }

  User.fromMap(Map map){
    genres = map["genres"];
    favorites = map["favorites"];
  }

  Map toMap(){
    return {
      "genres": genres,
      "favorites": favorites,
    };
  }

  String getGenresLikeString(){
    return this.genres.join(',');
  }

}