// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omdb/feature/data/model/movie_response.dart';
import 'package:omdb/feature/presentation/movie_page_state.dart';
import 'package:omdb/feature/presentation/movie_page_viewmodel.dart';

class MoviePage extends ConsumerWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewState = ref.watch(movieViewStateProvider);
    final viewModel = ref.read(movieViewModelProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text("some text"),
        ),
        body: _handleStateOfBody(viewState, viewModel));
  }
}

Widget _handleStateOfBody(MoviePageState state, MoviePageViewModel viewModel) {
  switch (state.runtimeType) {
    case InitialState:
      {
        return _handleInitialState(viewModel);
      }
    case OnSuccessMovieRequest:
      {
        return _onSuccessMovieRequest(
            state as OnSuccessMovieRequest, viewModel);
      }
    case OnLoading:
      {
        return _buildLoading();
      }
    default:
      return Text("Error");
  }
}

Widget _handleInitialState(MoviePageViewModel viewModel) {
  return Center(
    child: TextButton(
        onPressed: () {
          viewModel.getMovies("Avengers");
        },
        child: Text("Search Avengers Movies")),
  );
}

Widget _onSuccessMovieRequest(
    OnSuccessMovieRequest state, MoviePageViewModel viewModel) {
  if (state.movies.isNotEmpty) {
    return _movieList(state.movies);
  } else {
    return Text("Error");
  }
}

Widget _buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

ListView _movieList(List<MovieResponseData> movies) => ListView.builder(
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

//  FutureBuilder<MovieResponse>(
//           future: apiService.getMovies("Avengers"),
//           builder: (_, snapshot) {
//             if (snapshot.hasData) {
//               List<MovieResponseData> movies = snapshot.data!.data!;
//               return ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   itemCount: movies.length - 1,
//                   itemBuilder: (buildContext, index) {
//                     var movie = movies[index];
//                     return _MovieItem(
//                         url: movie.image?.imageUrl,
//                         title: movie.title!,
//                         type: movie.titleType!,
//                         year: movie.year!);
//                   });
//             } else if (snapshot.hasError) {
//               return const Icon(Icons.error_outline);
//             } else {
//               return Container(
//                 alignment: Alignment.center,
//                 constraints: const BoxConstraints.expand(),
//                 child: const CircularProgressIndicator(),
//               );
//             }
//           })
class _MovieItem extends StatelessWidget {
  String? url;
  String title;
  String type;
  int year;
  bool? isFavorite = false;

  _MovieItem(
      {super.key,
      this.url,
      required this.title,
      required this.type,
      required this.year,
      this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Title clicked is: $title")))
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
              _getImageWidget(url),
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: _getTextContent(title, type))
            ],
          ),
        ),
      ),
    );
  }

  _getImageWidget(String? url) {
    if (url != null) {
      return CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: url!,
        height: 180,
        width: 120,
        errorWidget: (context, url, error) => Icon(Icons.error),
        placeholder: (context, url) => Center(
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
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
          Text(
            type,
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
                        if (isFavorite.orFalse()) {
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
