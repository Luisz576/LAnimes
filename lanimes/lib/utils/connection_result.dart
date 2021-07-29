enum ConnectionResult {
  SUCCESS,
  BAD_REQUEST,
  NO_CONNECTION,
  NONE,
}

extension ConnectionResultExtension on ConnectionResult{
  int getId(){
    switch(this){
      case ConnectionResult.SUCCESS:
        return 200;
      case ConnectionResult.NO_CONNECTION:
        return 301;
      case ConnectionResult.BAD_REQUEST:
        return 401;
      default:
        return -1;
    }
  }
}

ConnectionResult getConnectionResultById(int value){
  switch(value){
      case 200:
        return ConnectionResult.SUCCESS;
      case 301:
        return ConnectionResult.NO_CONNECTION;
      case 401:
        return ConnectionResult.BAD_REQUEST;
      default:
        return ConnectionResult.NONE;
    }
}