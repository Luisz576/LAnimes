enum ConnectionResult {
  SUCCESS,
  //LAnimesApi ERRORS
  INVALID_PARAMS,
  ACCESS_BLOCKED,
  USER_ALREADY_EXISTS,
  USER_OR_PASSWORD_INCORRECT,
  USER_NOT_FOUNDED,
  //JikanApi ERRORS
  BAD_REQUEST,
  //ERROS PRÓPRIOS DO APP
  NO_CONNECTION,
  NONE,
}

extension ConnectionResultExtension on ConnectionResult{
  int getId(){
    switch(this){
      case ConnectionResult.INVALID_PARAMS:
        return 101;
      case ConnectionResult.ACCESS_BLOCKED:
        return 102;
      case ConnectionResult.USER_ALREADY_EXISTS:
        return 103;
      case ConnectionResult.USER_OR_PASSWORD_INCORRECT:
        return 104;
      case ConnectionResult.USER_NOT_FOUNDED:
        return 105;
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
      case 101:
        return ConnectionResult.INVALID_PARAMS;
      case 102:
        return ConnectionResult.ACCESS_BLOCKED;
      case 103:
        return ConnectionResult.USER_ALREADY_EXISTS;
      case 104:
        return ConnectionResult.USER_OR_PASSWORD_INCORRECT;
      case 105:
        return ConnectionResult.USER_NOT_FOUNDED;
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