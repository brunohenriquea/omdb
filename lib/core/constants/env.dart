// ignore_for_file: constant_identifier_names, non_constant_identifier_names, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/foundation.dart' as foundation;

class Env {
  static const bool IS_RELEASE = foundation.kReleaseMode;

  static const bool IS_DEBUG = !foundation.kReleaseMode;

  static final bool IS_TEST = Platform.environment.containsKey('FLUTTER_TEST');

  _EnvData get config => IS_RELEASE ? prod : dev;

  static final _EnvData dev = _EnvData(
    debug: true,
    debugShowCheckedModeBanner: false,
    debugShowMaterialGrid: false,
    debugApiClient: true,
    apiBaseUrl: "https://imdb8.p.rapidapi.com/",
  );

  static final _EnvData prod = _EnvData(
    debug: false,
    debugShowCheckedModeBanner: false,
    debugShowMaterialGrid: false,
    debugApiClient: false,
    apiBaseUrl: "https://imdb8.p.rapidapi.com/",
  );
}

class _EnvData {
  final bool debug;
  final bool debugShowCheckedModeBanner;
  final bool debugShowMaterialGrid;
  final bool debugApiClient;
  final String apiBaseUrl;

  _EnvData({
    required this.debug,
    required this.debugShowCheckedModeBanner,
    required this.debugShowMaterialGrid,
    required this.debugApiClient,
    required this.apiBaseUrl,
  });
}
