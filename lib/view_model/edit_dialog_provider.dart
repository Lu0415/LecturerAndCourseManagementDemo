import 'package:flutter/material.dart';

class EditDialogProvider extends ChangeNotifier {
  bool _isLecturerEditDataIsNotEmpty = false;
  bool _isCourseEditDataIsNotEmpty = false;

  // 檢查講師資訊輸入框是否為空
  void checkLecturerEditDataIsNotEmpty(String name, String major) {
    _isLecturerEditDataIsNotEmpty =
        ((name.isNotEmpty || name != '') && (major.isNotEmpty || major != ''));
    notifyListeners();
  }

  // 檢查講課程訊輸入框是否為空
  void checkCourseEditDataIsNotEmpty(String lecturerName, String courseName,
      String date, String time, String courseContext) {
    _isCourseEditDataIsNotEmpty =
        ((lecturerName.isNotEmpty || lecturerName != '') &&
            (courseName.isNotEmpty || courseName != '') &&
            (date.isNotEmpty || date != '') &&
            (time.isNotEmpty || time != '') &&
            (courseContext.isNotEmpty || courseContext != ''));
    notifyListeners();
  }

  bool get isLecturerEditDataIsNotEmpty => _isLecturerEditDataIsNotEmpty;
  bool get isCourseEditDataIsNotEmpty => _isCourseEditDataIsNotEmpty;
}
