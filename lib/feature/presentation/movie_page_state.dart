import '../data/model/movie_response.dart';

abstract class MoviePageState {}

class OnSuccessMovieRequest extends MoviePageState {
  List<MovieResponseData> movies;

  OnSuccessMovieRequest({required this.movies});
}

class InitialState extends MoviePageState {}

class OnLoading extends MoviePageState {
  bool isLoading;

  OnLoading(this.isLoading);
}

class OnError extends MoviePageState {
  Error error;

  OnError(this.error);
}
