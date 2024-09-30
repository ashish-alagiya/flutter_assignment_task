import 'package:get/get.dart';
import 'package:test_task/app/data/models/movie_list_model.dart';
import 'package:test_task/utiils/app_base_url.dart';

class MovieService {
  Future<MovieListModel> fetchMovies(int page) async {
    final response =
        await GetConnect().get('${AppBaseUrl().movieListUrl}?page=$page');

    if (response.status.hasError) {
      throw Exception('Failed to load movies');
    }

    return movieListModelFromJson(response.bodyString!);
  }
}
