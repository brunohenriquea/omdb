import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:omdb/core/di/app_module.dart';
import 'package:omdb/feature/presentation/movie_page.dart';

void main() async {
  await getItInit(env: Environment.dev);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: SafeArea(
        child: MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.red,
              visualDensity: VisualDensity.adaptivePlatformDensity
          ),
          home: MoviePage(),
        ),
      ),
    );
  }
}
