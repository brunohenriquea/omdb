// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:omdb/core/di/app_module.dart';
import 'package:omdb/feature/data/api_service.dart';
import 'package:omdb/feature/data/model/movie_response.dart';



class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {

  APIService apiService = getIt<APIService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("some text"),
      ),
      body: FutureBuilder<MovieResponse>(
          future: apiService.getMovies("Avengers"),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              List<MovieResponseData> movies = snapshot.data!.data!;
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: movies.length - 1,
                  itemBuilder: (buildContext, index) {
                    var movie = movies[index];
                    return _MovieItem(
                        url: movie.image?.imageUrl,
                        title: movie.title!,
                        type: movie.titleType!,
                        year: movie.year!);
                  });
            } else if (snapshot.hasError) {
              return const Icon(Icons.error_outline);
            } else {
              return Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints.expand(),
                child: const CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class _MovieItem extends StatefulWidget {
  String? url;
  String title;
  String type;
  int year;
  bool? isFavorite = false;

  _MovieItem({super.key,
    this.url,
    required this.title,
    required this.type,
    required this.year,
    this.isFavorite});

  @override
  State<_MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<_MovieItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Title clicked is: ${widget.title}")))
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.hardEdge,
        borderOnForeground: true,
        child: SizedBox(
          height: 180,
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            direction: Axis.horizontal,
            children: [
              _getImageWidget(widget.url),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: _getTextContent(widget.title, widget.type))
            ],
          ),
        ),
      ),
    );
  }

  _getImageWidget(String? url) {
    if (widget.url != null) {
      return CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: widget.url!,
        height: 180,
        width: 120,
        errorWidget: (context, url, error) => Icon(Icons.error),
        placeholder: (context, url) =>
            Center(
                child: SizedBox(
                    height: 30, width: 30, child: CircularProgressIndicator())),
      );
    } else {
      return Image.asset(
          height: 180, width: 120, "assets/movie_placeholder.png");
    }
  }

  _getTextContent(String title, String type) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        direction: Axis.vertical,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
          Text(
            widget.type,
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
          Spacer(
            flex: 5,
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text("data")),
                Flexible(
                    flex: 1,
                    child: Icon(
                          () {
                        if (widget.isFavorite.orFalse()) {
                          Icons.favorite;
                        } else {
                          Icons.favorite_border;
                        }
                      }(),
                      color: Colors.red,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension BoolExtensions on bool? {
  bool orFalse() {
    return this != null;
  }
}