import 'package:flutter/material.dart';
import 'package:student_course_selection_demo/utilities.dart';
import '../model/model.dart';

class LecturerProvider extends ChangeNotifier {
  int _listCount = 0;
  final List<bool> _expansionTileStates = [];
  List<Lecturer> _lecturers = [];
  List<List<Course>> _courses = [];

  void setExpansionTileData(
      List<Lecturer> lecturers, List<List<Course>> courses) {
    _listCount = lecturers.length;
    _lecturers = lecturers;
    _courses = courses;

    for (var _ in Iterable.generate(_listCount)) {
      _expansionTileStates.add(false);
    }
  }

  // 改變 ExpansionTile trailing icon
  void changeExpansionTileStates(int index) {
    _expansionTileStates[index] = !_expansionTileStates[index];
    notifyListeners();
  }

  // 取得講師課程
  List<Course> _getCoursesByLecturer(int index) {
    int id = _lecturers[index].lecturerId;
    List<Course> list = _courses.firstWhere(
      (e) => e.isNotEmpty && e.first.lecturerId == id,
      orElse: () => [],
    );
    return list;
  }

  // 取得課程數量
  int getCoursesCount(int index) {
    return _getCoursesByLecturer(index).length;
  }

  // 取得單一課程
  Course getCourse(int listIndex, int tileIndex) {
    return _getCoursesByLecturer(listIndex)[tileIndex];
  }

  // 取得課程時間
  String getDateTime(int listIndex, int tileIndex) {
    return '${_getCoursesByLecturer(listIndex)[tileIndex].date}, ${_getCoursesByLecturer(listIndex)[tileIndex].time}';
  }

  // 製作頭像
  String getFaceImageText(int index){
    String name = _lecturers[index].username;
    return setupFaceText(name);
  }

  int get listCount => _listCount;
  List<bool> get expansionTileStates => _expansionTileStates;
  List<Lecturer> get lecturers => _lecturers;
  List<List<Course>> get courses => _courses;
}
