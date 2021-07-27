import 'package:http/http.dart' as http;
import 'package:lanimes/models/ApiResponse.dart';
import 'package:lanimes/utils/connection_result.dart';
import 'package:lanimes/utils/jikan/search_type.dart';
import 'dart:convert';

class Api{

  static const String URL_LANIMES_BASE = "";
  static const String URL_JIKAN_BASE = "";

  //LAnimes Api
  //PROCESSO PADRÃO DA MINHA API
  Future<ApiResponse> _defaultQueryLAnimesApi({ required url, isPost = true, Object? body, Map<String, String>? headers }) async{
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
    final String urlPath = "$URL_LANIMES_BASE/sessions/new";
    return await _defaultQueryLAnimesApi(url: urlPath,
      body: {
        "username": username,
        "password": password,
      },
    );
  }

  Future<ApiResponse> loginWithUsernameAndPassword(String username, String password) async{
    final String urlPath = "$URL_LANIMES_BASE/sessions";
    return await _defaultQueryLAnimesApi(url: urlPath,
      body: {
        "username": username,
        "password": password,
      }
    );
  }

  Future<ApiResponse> loginWithUsernameAndToken(String username, String token) async{
    final String urlPath = "$URL_LANIMES_BASE/sessions";
    return await _defaultQueryLAnimesApi(url: urlPath,
      body: {
        "username": username,
      },
      headers: {
        "token": token,
      }
    );
  }

  Future<ApiResponse> getUserInfo(String username, String token) async{
    final String urlPath = "$URL_LANIMES_BASE/users/$username";
    return await _defaultQueryLAnimesApi(url: urlPath,
      isPost: false,
      headers: {
        "token": token,
      }
    );
  }

  Future<ApiResponse> setGenres(String username, String token, List<String> genres) async{
    final String urlPath = "$URL_LANIMES_BASE/users/$username/genres";
    return await _defaultQueryLAnimesApi(url: urlPath,
      headers: {
        "token": token,
      },
      body: {
        "genres": genres.length > 0 ? genres.join(',') : "",
      },
    );
  }

  Future<ApiResponse> toggleFavorite(String username, String token, String animeMangaId) async{
    final String urlPath = "$URL_LANIMES_BASE/users/$username/favorites/$animeMangaId";
    return await _defaultQueryLAnimesApi(url: urlPath,
      isPost: false,
      headers: {
        "token": token,
      }
    );
  }

  //MyAnimeList's Api
  Future<ApiResponse> _defaultQueryMyAnimeListApi({ required String url }) async{
    ConnectionResult connectionResult = ConnectionResult.NO_CONNECTION;
    Map res = {};

    var response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      connectionResult = ConnectionResult.NONE;
      final data = jsonDecode(response.body);
      if(data["status"] != 400)
        connectionResult = ConnectionResult.SUCCESS;
      else
        connectionResult = ConnectionResult.BAD_REQUEST;
      res = data;
    }

    return ApiResponse(status: connectionResult, data: res);
  }

  Future<ApiResponse> searchData(SearchType type, { String q = '', int page = 1, genre = '' }) async{
    final String urlPath = "$URL_JIKAN_BASE/search/${type.toUrlString()}?q=$q&page=$page${genre != '' ? '&genre=$genre' : ''}";
    return await _defaultQueryMyAnimeListApi(url: urlPath);
  }

  Future<ApiResponse> getAnimeData(int animeId) async{
    final String urlPath = "$URL_JIKAN_BASE/anime/$animeId/";
    return await _defaultQueryMyAnimeListApi(url: urlPath);
  }

  Future<ApiResponse> getMangaData(int mangaId) async{
    final String urlPath = "$URL_JIKAN_BASE/manga/$mangaId/";
    return await _defaultQueryMyAnimeListApi(url: urlPath);
  }

}