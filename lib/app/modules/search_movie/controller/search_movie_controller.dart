import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/app/data/models/movie_list_model.dart';
import 'package:test_task/utiils/app_base_url.dart';

class SearchMovieController extends GetxController {
  final TextEditingController movieNameController = TextEditingController();

  var searchResults = <TvShow>[].obs;
  var isLoading = false.obs;
  var isFetchingMore = false.obs;
  var hasMore = true.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  Timer? _debounce;

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  void searchMovies(String movieName, {bool isNextPage = false}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (!isNextPage) {
        isLoading.value = true;
        searchResults.clear();
        currentPage.value = 1;
      } else {
        isFetchingMore.value = true;
      }

      final String apiUrl =
          '${AppBaseUrl().searchUrl}=$movieName&page=${currentPage.value}';
      try {
        final response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          final movieListModel = movieListModelFromJson(response.body);

          if (movieListModel.tvShows != null &&
              movieListModel.tvShows!.isNotEmpty) {
            searchResults.addAll(movieListModel.tvShows!);
            currentPage.value++;
            totalPages.value = movieListModel.page ?? 1;
            hasMore.value = currentPage.value <= totalPages.value;
          } else {
            hasMore.value = false;
          }
        } else {
          throw Exception('Failed to load movies');
        }
      } catch (e) {
        log('Error: $e');
      } finally {
        isLoading.value = false;
        isFetchingMore.value = false;
      }
    });
  }

  void loadMoreMovies() {
    if (hasMore.value && !isFetchingMore.value) {
      searchMovies(movieNameController.text, isNextPage: true);
    }
  }
}
