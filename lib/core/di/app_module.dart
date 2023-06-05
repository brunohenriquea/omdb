import 'package:omdb/core/constants/env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final envProvider = Provider<Env>((ref) {
  return Env();
});

final baseUrlProvider = Provider<String>((ref) {
  return ref.read(envProvider).config.apiBaseUrl;
});

final apiKeyProvider = Provider<String>((ref) {
  return "5053fbe20dmsh3ec833de176001ep18f609jsnfbe7e3fdba9f";
});
