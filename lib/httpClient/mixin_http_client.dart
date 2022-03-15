
import 'package:dio/dio.dart';
import 'package:flutter_instagram/httpClient/base_url.dart';


mixin HttpClient {
  Future<Response<dynamic>?> callApi(RequestTypes type, String url, dynamic body, Map<String, dynamic>? header) async{
    final dio = Dio(); 
    switch(type){

      case RequestTypes.get:
        print("Oi");
        final result = await dio.get(baseUrl+url, options: Options(headers: header,));
        print("Oi2");
        return result;
      case RequestTypes.post:
        final result = await dio.post(baseUrl+url, data: body, options: Options(headers: header));
        return result;
      case RequestTypes.update:
    }

  }
}

enum RequestTypes {
  post,
  get,
  update,
}
