import 'package:http/http.dart' as http;
import 'package:lanimes/models/ApiResponse.dart';
import 'package:lanimes/utils/connection_result.dart';
import 'package:lanimes/utils/myanimelist/search_type.dart';
import 'dart:convert';

class Api{
  static const String URL_MYANIMELIST_BASE = "https://api.myanimelist.net/v2";

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
    final String urlPath = "$URL_MYANIMELIST_BASE/search/${type.toUrlString()}?q=$q&page=$page${genre != '' ? '&genre=$genre' : ''}";
    return await _defaultQueryMyAnimeListApi(url: urlPath);
  }

  Future<ApiResponse> getAnimeData(int animeId) async{
    final String urlPath = "$URL_MYANIMELIST_BASE/anime/$animeId/";
    return await _defaultQueryMyAnimeListApi(url: urlPath);
  }

  Future<ApiResponse> getMangaData(int mangaId) async{
    final String urlPath = "$URL_MYANIMELIST_BASE/manga/$mangaId/";
    return await _defaultQueryMyAnimeListApi(url: urlPath);
  }

}