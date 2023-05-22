
import 'package:dio/dio.dart';
class HeaderInterceptor extends Interceptor {

  String apiKey;

  HeaderInterceptor(this.apiKey);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers["X-RapidAPI-Key"] = apiKey;
    super.onRequest(options, handler);
  }
}
