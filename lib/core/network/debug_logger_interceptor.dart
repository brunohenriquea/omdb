import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DebugLoggerInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
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
