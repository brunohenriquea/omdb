// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:omdb/core/constants/env.dart' as _i6;
import 'package:omdb/core/network/debug_logger_interceptor.dart' as _i4;
import 'package:omdb/feature/data/api_service.dart' as _i3;
import 'package:omdb/feature/data/di/data_module.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i3.APIService>(() => networkModule.apiService);
    gh.factory<_i4.DebugLoggerInterceptor>(() => _i4.DebugLoggerInterceptor());
    gh.lazySingleton<_i5.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i6.Env>(() => _i6.Env());
    gh.lazySingleton<String>(
      () => networkModule.apiKey,
      instanceName: 'apiKey',
    );
    return this;
  }
}

class _$NetworkModule extends _i7.NetworkModule {}
