// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:test_task/app/modules/movie_detail/bindings/movie_detail_binding.dart';
import 'package:test_task/app/modules/movie_detail/view/movie_detail_view.dart';
import 'package:test_task/app/modules/movie_display/bindings/movie_display_binding.dart';
import 'package:test_task/app/modules/movie_display/view/movie_display_view.dart';
import 'package:test_task/app/modules/search_movie/bindings/search_movie_binding.dart';
import 'package:test_task/app/modules/search_movie/view/search_movie_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MOVIE_LIST;

  static final routes = [
    GetPage(
      name: _Paths.MOVIE_LIST,
      page: () => MovieDisplayView(),
      binding: MovieDisplayBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_MOVIE,
      page: () => SearchMovieView(),
      binding: SearchMovieBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE_DETAIL,
      page: () => MovieDetailView(),
      binding: MovieDetailBinding(),
    ),
  ];
}
