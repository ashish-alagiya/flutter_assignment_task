import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:test_task/app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Lead Management",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
