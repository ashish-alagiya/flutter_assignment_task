import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/app/modules/movie_detail/controller/movie_detail_controller.dart';
import 'package:test_task/utiils/app_color.dart';
import 'package:test_task/utiils/app_text_style.dart';

class MovieDetailView extends StatelessWidget {
  final MovieDetailController movieDetailController =
      Get.put(MovieDetailController());

  MovieDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Movie Details', style: AppTextStyle.white16_500),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.navigate_before,
              color: white,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: movieDetailController.movieImage.toString(),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Movie name : ${movieDetailController.movieName}",
                  style: AppTextStyle.white16_500,
                ),
                Text(
                  "Permalink : ${movieDetailController.moviePermalink}",
                  style: AppTextStyle.white16_500,
                ),
                Text(
                  "Country : ${movieDetailController.country}",
                  style: AppTextStyle.white16_500,
                ),
                Text(
                  "Start Date : ${movieDetailController.startDate}",
                  style: AppTextStyle.white16_500,
                ),
                Text(
                  "End Date : ${movieDetailController.endDate}",
                  style: AppTextStyle.white16_500,
                ),
                Text(
                  "Network : ${movieDetailController.network}",
                  style: AppTextStyle.white16_500,
                ),
                Text(
                  "Status : ${movieDetailController.status}",
                  style: AppTextStyle.white16_500,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
