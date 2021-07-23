import 'package:http/http.dart' as http;
import 'package:lanimes/models/ApiResponse.dart';
import 'package:lanimes/utils/connection_result.dart';
import 'dart:convert';

class Api{
  final String URL_BASE = "url base de onde a api está rodando";

  //LAnimes Api
  //PROCESSO PADRÃO DA MINHA API
  Future<ApiResponse> _LAnimesApiDefaultQuery({ required url, isPost = true, Object? body, Map<String, String>? headers }) async{
    ConnectionResult connectionResult = ConnectionResult.NO_CONNECTION;
    Map res = {};

    //Usando json
    headers?['Content-Type'] = 'application/json; charset=UTF-8';

    //Construção da requisição
    var response = await (isPost ? http.post(Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    ) : http.get(Uri.parse(url),
      headers: headers,
    ));

    //verificações + data
    if(response.statusCode == 200){
      connectionResult = ConnectionResult.NONE;
      final data = jsonDecode(response.body);
      if(data["success"] != null)
        connectionResult = ConnectionResult.SUCCESS;
      else 
        connectionResult = getConnectionResultById(data["error_id"]);
      res = data;
    }

    return ApiResponse(status: connectionResult, data: res);
  }

  Future<ApiResponse> registerNewUser(String username, String password) async{
    final String url_path = "$URL_BASE/sessions/new";
    return await _LAnimesApiDefaultQuery(url: url_path,
      body: {
        "username": username,
        "password": password,
      },
    );
  }

  Future<ApiResponse> loginWithUsernameAndPassword(String username, String password) async{
    final String url_path = "$URL_BASE/sessions";
    return await _LAnimesApiDefaultQuery(url: url_path,
      body: {
        "username": username,
        "password": password,
      }
    );
  }

  Future<ApiResponse> loginWithUsernameAndToken(String username, String token) async{
    final String url_path = "$URL_BASE/sessions";
    return await _LAnimesApiDefaultQuery(url: url_path,
      body: {
        "username": username,
      },
      headers: {
        "token": token,
      }
    );
  }

  Future<ApiResponse> getUserInfo(String username, String token) async{
    final String url_path = "$URL_BASE/users/$username";
    return await _LAnimesApiDefaultQuery(url: url_path,
      isPost: false,
      headers: {
        "token": token,
      }
    );
  }

  Future<ApiResponse> setGenres(String username, String token, List<String> genres) async{
    final String url_path = "$URL_BASE/users/$username/genres";
    return await _LAnimesApiDefaultQuery(url: url_path,
      headers: {
        "token": token,
      },
      body: {
        "genres": genres.length > 0 ? genres.join(',') : "",
      },
    );
  }

  Future<ApiResponse> toggleFavorite(String username, String token, String anime_manga_id) async{
    final String url_path = "$URL_BASE/users/$username/favorites/$anime_manga_id";
    return await _LAnimesApiDefaultQuery(url: url_path,
      isPost: false,
      headers: {
        "token": token,
      }
    );
  }

  //Jikan's Api

}