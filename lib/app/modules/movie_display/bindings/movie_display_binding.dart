import 'package:get/get.dart';
import 'package:test_task/app/modules/movie_display/controller/movie_display_controller.dart';

class MovieDisplayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieDisplayController>(
      () => MovieDisplayController(),
    );
  }
}
