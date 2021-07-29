enum SearchType{
  ANIME,
  MANGA,
  PERSON,
  CHARACTER
}

extension SearchTypeExtension on SearchType{
  String toUrlString(){
    switch(this){
      case SearchType.ANIME:
        return 'anime';
      case SearchType.MANGA:
        return 'manga';
      case SearchType.PERSON:
        return 'person';
      case SearchType.CHARACTER:
        return 'character';
    }
  }
}