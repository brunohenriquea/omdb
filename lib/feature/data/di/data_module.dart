import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omdb/core/di/app_module.dart';
import 'package:omdb/core/network/auth_header_interceptor.dart';
import 'package:omdb/core/network/debug_logger_interceptor.dart';
import 'package:omdb/feature/data/api_service.dart';

final dioProvider = Provider<Dio>((ref) {
  final baseUrl = ref.read(baseUrlProvider);
  final apiKey = ref.read(apiKeyProvider);
  final baseOptions = BaseOptions();
  final dio = Dio(baseOptions);
  baseOptions.baseUrl = baseUrl;
  dio.interceptors.add(HeaderInterceptor(apiKey));
  dio.interceptors.add(DebugLoggerInterceptor());
  return dio;
});

final apiServiceProvider = Provider<APIService>((ref) {
  final dio = ref.read(dioProvider);
  return APIService(dio);
});
