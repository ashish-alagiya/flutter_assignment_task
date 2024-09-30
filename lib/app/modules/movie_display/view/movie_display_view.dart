import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/app/modules/movie_display/controller/movie_display_controller.dart';
import 'package:test_task/app/routes/app_pages.dart';
import 'package:test_task/utiils/app_color.dart';
import 'package:test_task/utiils/app_text_style.dart';
import 'package:test_task/utiils/common_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDisplayView extends StatelessWidget {
  final MovieDisplayController movieController =
      Get.put(MovieDisplayController());
  final ScrollController _scrollController = ScrollController();

  MovieDisplayView({super.key}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        movieController.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Popular TV Shows', style: AppTextStyle.white16_500),
      ),
      body: Obx(() {
        if (movieController.isLoading.value &&
            movieController.movieList.isEmpty) {
          return Center(child: commonLoader());
        }

        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movieController.movieList.length,
                    itemBuilder: (context, index) {
                      final show = movieController.movieList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(Routes.MOVIE_DETAIL, arguments: {
                              "image": show.imageThumbnailPath,
                              "movieName": show.name,
                              "permalink": show.permalink,
                              "start-date": show.startDate,
                              "end-date": show.endDate,
                              "country": show.country,
                              "network": show.network,
                              "status": show.status
                            });
                          },
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: grey.withOpacity(0.3)),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: show.imageThumbnailPath ?? "",
                              placeholder: (context, url) => const Center(
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    )),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: movieController.movieList.length + 1,
                itemBuilder: (context, index) {
                  if (index == movieController.movieList.length) {
                    return movieController.isLoading.value
                        ? Center(child: commonLoader())
                        : const SizedBox();
                  }
                  final show = movieController.movieList[index];
                  return ListTile(
                    onTap: () {
                      Get.toNamed(Routes.MOVIE_DETAIL, arguments: {
                        "image": show.imageThumbnailPath,
                        "movieName": show.name,
                        "permalink": show.permalink,
                        "start-date": show.startDate,
                        "end-date": show.endDate,
                        "country": show.country,
                        "network": show.network,
                        "status": show.status
                      });
                    },
                    title: Text(show.name ?? 'No Name',
                        style: AppTextStyle.white16_500),
                    subtitle: Text(show.permalink ?? '',
                        style: AppTextStyle.grey12_500),
                    leading: Container(
                      height: 200,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: grey.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: show.imageThumbnailPath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: show.imageThumbnailPath ?? "",
                                placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      )),
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
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.SEARCH_MOVIE);
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
