import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:omdb/core/constants/env.dart';
import 'package:omdb/core/network/auth_header_interceptor.dart';
import 'package:omdb/core/network/debug_logger_interceptor.dart';
import 'package:omdb/feature/data/api_service.dart';


@module
abstract class NetworkModule {
  @LazySingleton()
  Dio get dio => (String apiKey) {
    final baseOptions = BaseOptions();
    final dio = Dio(baseOptions);
    baseOptions.baseUrl = env.config.apiBaseUrl;
    dio.interceptors.add(HeaderInterceptor(apiKey));
    dio.interceptors.add(DebugLoggerInterceptor());
    return dio;
      }(apiKey);

  @LazySingleton()
  APIService get apiService => (Dio dio) {
        return APIService(dio);
      }(dio);

  @LazySingleton()
  @Named("apiKey")
  String get apiKey => () {
        return "5053fbe20dmsh3ec833de176001ep18f609jsnfbe7e3fdba9f";
      }();
}
