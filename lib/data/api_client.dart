import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/http.dart';
import 'package:injectable/injectable.dart';
import 'model/movie_response.dart';
part 'api_client.g.dart';

class APIClient {
  static const String apiKey =
      "5053fbe20dmsh3ec833de176001ep18f609jsnfbe7e3fdba9f";
  static const String findMovies = "title/v2/find";
}

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(APIClient.findMovies)
  Future<MovieResponse> getMovies(@Query("title") String title);
}

//
// @injectable
// class ApiService {
//
//   @factoryMethod
//   APIClient
// }


class HeaderInterceptor extends Interceptor {

  String apiKey;

  HeaderInterceptor(this.apiKey);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["X-RapidAPI-Key"] = apiKey;
    debugPrint("Path ---->  ${options.path}");
    debugPrint("Headers ---->  ${options.headers}");
    debugPrint("method---->  ${options.method}");
    debugPrint("Url ---->  ${options.uri}");
    debugPrint("Body ---->  ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(" Response ---->  ${response.data}");
    debugPrint(" Code ---->  ${response.statusCode}");
    super.onResponse(response, handler);
  }
}
