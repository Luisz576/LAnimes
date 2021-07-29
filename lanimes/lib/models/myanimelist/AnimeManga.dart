import 'package:lanimes/utils/myanimelist/anime_manga_type.dart';
import 'package:lanimes/utils/myanimelist/anime_manga_status.dart';

class AnimeManga{

  late final int id;
  late final String title;
  late final AnimeMangaType type;
  late final AnimeMangaStatus status;
  late final List<String> genres;
  String? image, synopsis;
  double? score;
  Anime? anime;
  Manga? manga;

  AnimeManga({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    this.image,
    this.synopsis,
    this.score,
    this.anime,
    this.manga,
    this.genres = const []
  });

  AnimeManga.fromMap(Map map){
      this.id = map["mal_id"];
      this.title = map["title"];
      this.status = getAnimeMangaStatusFromString(map["status"]);
      this.image = map["image_url"];
      this.synopsis = map["synopsis"];
      this.type = getAnimeMangaTypeFromString(map["type"]);
      this.score = map["score"];
      this.genres = map["genres"] != null ?
      map["genres"].map((genre){
        return genre["name"];
      }) : [];
      if(this.type.whatIs() == 1)
        this.anime = Anime.fromMap(map);
      else if(this.type.whatIs() == 2)
        this.manga = Manga.fromMap(map);
  }

  int whatIs(){
    return this.type.whatIs();
  }

}

class Anime{
  
  int? episodes;
  String? duration, source;

  Anime({
    this.episodes = -1,
    this.duration = "",
    this.source = "",
  });

  Anime.fromMap(Map map){
    this.episodes = map["episodes"];
    this.duration = map["duration"];
    this.source = map["source"];
  }

}

class Manga{

  int? volumes, chapters;

  Manga({
    this.volumes = -1,
    this.chapters = -1,
  });

  Manga.fromMap(Map map){
    this.volumes = map["volumes"];
    this.chapters = map["chapters"];
  }

}