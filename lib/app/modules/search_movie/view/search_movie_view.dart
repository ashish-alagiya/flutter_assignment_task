import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/app/modules/search_movie/controller/search_movie_controller.dart';
import 'package:test_task/app/routes/app_pages.dart';
import 'package:test_task/utiils/app_color.dart';
import 'package:test_task/utiils/app_text_style.dart';
import 'package:test_task/utiils/common_widget.dart';

class SearchMovieView extends StatelessWidget {
  final SearchMovieController searchController =
      Get.put(SearchMovieController());
  final ScrollController _scrollController = ScrollController();

  SearchMovieView({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !searchController.isLoading.value &&
          !searchController.isFetchingMore.value) {
        searchController.loadMoreMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.navigate_before, color: white),
        ),
        title: Text('Search Movies', style: AppTextStyle.white16_500),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: grey,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: searchController.movieNameController,
                style: AppTextStyle.white16_500,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search movie name...',
                  hintStyle: AppTextStyle.grey12_500.copyWith(fontSize: 14),
                  contentPadding: const EdgeInsets.only(left: 20, top: 12),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      color: white,
                    ),
                    onPressed: () {
                      searchController.movieNameController.clear();
                      searchController.searchResults.clear();
                    },
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    searchController.searchMovies(value);
                  } else {
                    searchController.searchResults.clear();
                  }
                },
              ),
            ),
          ),
          Obx(() {
            if (searchController.isLoading.value) {
              return Padding(
                padding: const EdgeInsets.only(top: 250),
                child: commonLoader(),
              );
            } else if (searchController.searchResults.isEmpty &&
                searchController.movieNameController.text.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Text(
                  'No search results found.',
                  style: AppTextStyle.white16_500,
                ),
              );
            } else if (searchController.searchResults.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Text(
                  'Search movie name...',
                  style: AppTextStyle.white16_500,
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: searchController.searchResults.length +
                      (searchController.isFetchingMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == searchController.searchResults.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final movie = searchController.searchResults[index];
                    return ListTile(
                      onTap: () {
                        Get.toNamed(Routes.MOVIE_DETAIL, arguments: {
                              "image": movie.imageThumbnailPath,
                              "movieName": movie.name,
                              "permalink": movie.permalink,
                              "start-date": movie.startDate,
                              "end-date": movie.endDate,
                              "country": movie.country,
                              "network": movie.network,
                              "status": movie.status
                            });
                      },
                      title: Text(
                        movie.name ?? 'No Name',
                        style: AppTextStyle.white16_500,
                      ),
                      subtitle: Text(
                        movie.permalink ?? '',
                        style: AppTextStyle.grey12_500,
                      ),
                      leading: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: movie.imageThumbnailPath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: movie.imageThumbnailPath ?? "",
                                  placeholder: (context, url) => const Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              )
                            : null,
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
