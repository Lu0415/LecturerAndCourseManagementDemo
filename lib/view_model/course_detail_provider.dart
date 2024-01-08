
import 'package:flutter/material.dart';

import '../model/model.dart';

class CourseDetailProvider extends ChangeNotifier {

  Course? _course;

  // 設置資料
  void setDetail(Course course) {
    _course = course;
  }

  Course? get course => _course;

}