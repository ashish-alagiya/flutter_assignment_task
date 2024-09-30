import 'package:get/get.dart';
import 'package:test_task/app/modules/search_movie/controller/search_movie_controller.dart';

class SearchMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchMovieController>(
      () => SearchMovieController(),
    );
  }
}
