import 'package:lanimes/utils/connection_result.dart';

class ApiResponse{

  late final ConnectionResult status;
  late final Map data;

  ApiResponse({required status, required data}){
    this.status = status;
    this.data = data;
  }

}