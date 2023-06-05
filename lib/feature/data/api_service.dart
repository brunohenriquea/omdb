import 'package:dio/dio.dart';
import 'package:omdb/core/constants/network.dart';
import 'package:retrofit/http.dart';
import 'model/movie_response.dart';

part 'api_service.g.dart';

@RestApi()
abstract class APIService {
  factory APIService(Dio dio, {String baseUrl}) = _APIService;

  @GET(APIConstants.findMovies)
  Future<MovieResponse> getMovies(@Query("title") String title);
}
