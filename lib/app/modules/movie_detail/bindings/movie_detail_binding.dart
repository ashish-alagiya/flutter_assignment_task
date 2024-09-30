import 'package:get/get.dart';
import 'package:test_task/app/modules/movie_detail/controller/movie_detail_controller.dart';

class MovieDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieDetailController>(
      () => MovieDetailController(),
    );
  }
}
