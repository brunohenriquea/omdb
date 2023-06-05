import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omdb/feature/data/api_service.dart';
import 'package:omdb/feature/data/di/data_module.dart';
import 'package:omdb/feature/presentation/movie_page_state.dart';

final movieViewStateProvider =
    StateNotifierProvider<MoviePageViewModel, MoviePageState>((ref) {
  return MoviePageViewModel(apiService: ref.read(apiServiceProvider));
});

final movieViewModelProvider = Provider<MoviePageViewModel>((ref) {
  return ref.read(movieViewStateProvider.notifier);
});

class MoviePageViewModel extends StateNotifier<MoviePageState> {
  final APIService _apiService;

  MoviePageViewModel({required APIService apiService})
      : _apiService = apiService,
        super(InitialState());

  getMovies(String title) async {
    state = OnLoading(true);
    final response = await _apiService.getMovies(title);
    state = OnSuccessMovieRequest(movies: response.data ?? []);
  }
}
