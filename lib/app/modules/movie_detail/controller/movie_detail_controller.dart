import 'package:get/get.dart';

class MovieDetailController extends GetxController {
  var args = Get.arguments;
  String? movieImage;
  String? movieName;
  String? moviePermalink;
  String? country;
  DateTime? startDate;
  DateTime? endDate;
  String? network;
  String? status;

  @override
  Future<void> onInit() async {
    if (args != null) {
      movieImage = args["image"];
      movieName = args["movieName"];
      moviePermalink = args["permalink"];
      startDate = args["start-date"];
      endDate = args["end-date"];
      country = args["country"];
      status = args["status"];
      network = args["network"];
    }
    super.onInit();
  }
}
