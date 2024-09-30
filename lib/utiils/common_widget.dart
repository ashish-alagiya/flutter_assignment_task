import 'package:flutter/material.dart';
import 'package:test_task/utiils/app_color.dart';

Widget commonLoader({Color? color}) {
  return Center(
    child: CircularProgressIndicator(
      color: color ?? white,
    ),
  );
}

