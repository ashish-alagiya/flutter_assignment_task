import 'package:get/get.dart';
import 'package:test_task/app/data/models/movie_list_model.dart';
import 'package:test_task/utiils/service.dart';

class MovieDisplayController extends GetxController {
  final MovieService _movieService = MovieService();

  var movieList = <TvShow>[].obs;
  var isLoading = true.obs;
  var page = 1.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    fetchMovies(page.value);
    super.onInit();
  }

  void fetchMovies(int pageNumber) async {
    if (!hasMore.value) return;

    isLoading.value = true;

    try {
      MovieListModel movieListModel =
          await _movieService.fetchMovies(pageNumber);
      if (movieListModel.tvShows!.isEmpty) {
        hasMore.value = false;
      } else {
        movieList.addAll(movieListModel.tvShows!);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void loadMore() {
    if (isLoading.value) return;
    page.value++;
    fetchMovies(page.value);
  }
}
