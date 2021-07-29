enum AnimeMangaStatus{
  AIRING,
  COMPLETED,
  COMPLETE,
  TO_BE_AIRED,
  TBA,
  UPCOMING,
  PUBLISHING,
  TO_BE_PUBLISHED,
  TBP,
  //NONE
  NONE,
}

extension AnimeMangaStatusExtension on AnimeMangaStatus{
  String toUrlString(){
    switch(this){
      case AnimeMangaStatus.AIRING:
        return 'airing';
      case AnimeMangaStatus.COMPLETED:
        return 'completed';
      case AnimeMangaStatus.COMPLETE:
        return 'complete';
      case AnimeMangaStatus.TO_BE_AIRED:
        return 'to_be_aired';
      case AnimeMangaStatus.TBA:
        return 'tba';
      case AnimeMangaStatus.UPCOMING:
        return 'upcoming';
      case AnimeMangaStatus.PUBLISHING:
        return 'publishing';
      case AnimeMangaStatus.TO_BE_PUBLISHED:
        return 'to_be_published';
      case AnimeMangaStatus.TBP:
        return 'tbp';
      //NONE
      default:
        return 'none';
    }
  }
}

AnimeMangaStatus getAnimeMangaStatusFromString(String status){
  switch(status){
    case 'airing':
      return AnimeMangaStatus.AIRING;
    case 'completed':
      return AnimeMangaStatus.COMPLETED;
    case 'complete':
      return AnimeMangaStatus.COMPLETE;
    case 'to_be_aired':
      return AnimeMangaStatus.TO_BE_AIRED;
    case 'tba':
      return AnimeMangaStatus.TBA;
    case 'upcoming':
      return AnimeMangaStatus.UPCOMING;
    case 'publishing':
      return AnimeMangaStatus.PUBLISHING;
    case 'to_be_published':
      return AnimeMangaStatus.TO_BE_PUBLISHED;
    case 'tbp':
      return AnimeMangaStatus.TBP;
    //NONE
    default:
      return AnimeMangaStatus.NONE;
  }
}