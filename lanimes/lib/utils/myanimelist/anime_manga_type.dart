enum AnimeMangaType{
  //ANIME
  TV,
  OVA,
  MOVIE,
  SPECIAL,
  ONA,
  MUSIC,
  //MANGA
  MANGA,
  NOVEL,
  ONESHOT,
  DOUJIN,
  MANHWA,
  MANHUA,
  //NONE
  NONE
}

extension AnimeMangaTypeExtension on AnimeMangaType{
  String toUrlString(){
    switch(this){
      //ANIME
      case AnimeMangaType.TV:
        return 'tv';
      case AnimeMangaType.OVA:
        return 'ova';
      case AnimeMangaType.MOVIE:
        return 'movie';
      case AnimeMangaType.SPECIAL:
        return 'special';
      case AnimeMangaType.ONA:
        return 'ona';
      case AnimeMangaType.MUSIC:
        return 'music';
      //MANGA
      case AnimeMangaType.MANGA:
        return 'manga';
      case AnimeMangaType.NOVEL:
        return 'novel';
      case AnimeMangaType.ONESHOT:
        return 'oneshot';
      case AnimeMangaType.DOUJIN:
        return 'doujin';
      case AnimeMangaType.MANHWA:
        return 'manhwa';
      case AnimeMangaType.MANHUA:
        return 'manhua';
      //NONE
      default:
        return 'none';
    }
  }
  int whatIs(){ // 1 - Anime / 2 - Manga / 0 - none
    return (
      this == AnimeMangaType.TV ||
      this == AnimeMangaType.OVA ||
      this == AnimeMangaType.MOVIE ||
      this == AnimeMangaType.SPECIAL ||
      this == AnimeMangaType.ONA ||
      this == AnimeMangaType.MUSIC
    ) ? 1 : (
      this == AnimeMangaType.MANGA ||
      this == AnimeMangaType.NOVEL ||
      this == AnimeMangaType.ONESHOT ||
      this == AnimeMangaType.DOUJIN ||
      this == AnimeMangaType.MANHWA ||
      this == AnimeMangaType.MANHUA
    ) ? 2 : 0;
  }
}

AnimeMangaType getAnimeMangaTypeFromString(String? type){
  if(type == null) return AnimeMangaType.NONE;
  switch(type.trim().toLowerCase()){
      //ANIME
      case 'tv':
        return AnimeMangaType.TV;
      case 'ova':
        return AnimeMangaType.OVA;
      case 'special':
        return AnimeMangaType.SPECIAL;
      case 'movie':
        return AnimeMangaType.MOVIE;
      case 'ona':
        return AnimeMangaType.ONA;
      case 'music':
        return AnimeMangaType.MUSIC;
      //MANGA
      case 'manga':
        return AnimeMangaType.MANGA;
      case 'novel':
        return AnimeMangaType.NOVEL;
      case 'oneshot':
        return AnimeMangaType.ONESHOT;
      case 'doujin':
        return AnimeMangaType.DOUJIN;
      case 'manhwa':
        return AnimeMangaType.MANHWA;
      case 'manhua':
        return AnimeMangaType.MANHUA;
      //NONE
      default:
        return AnimeMangaType.NONE;
    }
}