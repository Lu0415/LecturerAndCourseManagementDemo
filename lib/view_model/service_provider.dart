import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import '../model/model.dart';
import '../utilities.dart';

class ServiceProvider with ChangeNotifier {
  static int _globalCourseIdCounter = 0;
  static int _globalLectureIdCounter = 1000;
  final List<Lecturer> _lecturerList = [];
  final List<List<Course>> _coursesByLecturer = [];

  // 製作假資料
  void getServiceData() {
    // 製作假講師資料
    for (int i = 0; i < 6; i++) {
      _lecturerList.add(Lecturer(
        lecturerId: _globalLectureIdCounter++,
        username: faker.person.name(),
        password: faker.internet.password(),
        major: getRandomSport(),
      ));
    }

    // 製作假課程資料
    for (var lecturer in _lecturerList) {
      List<Course> lecturerCourses = [];

      for (int i = 0; i < 3; i++) {
        lecturerCourses.add(Course(
          courseId: _globalCourseIdCounter++,
          courseName: getRandomSport(),
          lecturerId: lecturer.lecturerId,
          date: getRandomDate(),
          time: getRandomTime(),
          courseContent: faker.lorem.sentences(20).join('\n'),
        ));
      }

      _coursesByLecturer.add(lecturerCourses);
    }
  }

  // 課程列表
  List<List<Course>> get getCourseList => _coursesByLecturer;

  // 授課講師列表
  List<Lecturer> get getLecturerList => _lecturerList;

  // 授課講師所開課程列表
  List<Course> getLecturerCourses(int lecturerId) {
    List<Course> lecturerCourses = [];
    for (var coursesList in _coursesByLecturer) {
      for (var course in coursesList) {
        if (course.lecturerId == lecturerId) {
          lecturerCourses.add(course);
        }
      }
    }
    return lecturerCourses;
  }

  // 刪除講師 或 刪除課程
  void deleteItem(bool isLecturer, int deleteId) {
    if (isLecturer) {
      _lecturerList.removeWhere((lecturer) => lecturer.lecturerId == deleteId);
    }

    for (var coursesList in _coursesByLecturer) {
      coursesList.removeWhere((course) =>
          (isLecturer && course.lecturerId == deleteId) ||
          (!isLecturer && course.courseId == deleteId));
    }

    notifyListeners();
  }

  // 取得所有課程
  List<Course> get allCourses =>
      _coursesByLecturer.expand((coursesList) => coursesList).toList();

  // 取得講師名字
  String getUsernameById(int lecturerId) {
    Lecturer lecturer = _lecturerList.firstWhere(
        (lecturer) => lecturer.lecturerId == lecturerId,
        orElse: () => _unknownLecturer());
    return lecturer.username;
  }

  // 取得講師 id
  int getLecturerIdByName(String name) {
    Lecturer lecturer = _lecturerList.firstWhere(
        (lecturer) => lecturer.username == name,
        orElse: () => _unknownLecturer());
    return lecturer.lecturerId;
  }

  Lecturer _unknownLecturer() {
    return Lecturer(
        lecturerId: -1,
        username: 'Unknown',
        password: 'Unknown',
        major: 'Unknown');
  }

  // 更新講師資料
  void updateLecturer(int lecturerId, String name, String major) {
    int index = _lecturerList
        .indexWhere((lecturer) => lecturer.lecturerId == lecturerId);
    if (index != -1) {
      _lecturerList[index] = _lecturerList[index].copyWith(
        username: name,
        major: major,
      );
      notifyListeners();
    }
  }

  // 新增講師
  void addLecturer(String name, String major) {
    Lecturer newLecturer = Lecturer(
      lecturerId: _globalLectureIdCounter++,
      username: name,
      password: 'password', // 預填默認密碼
      major: major,
    );
    _lecturerList.add(newLecturer);
    notifyListeners();
  }

  // 取得所有講師名字
  List<String> get getLecturerNames =>
      _lecturerList.map((lecturer) => lecturer.username).toList();
  // 取得所有預設星期
  List<String> get getDateList => getDate();
  // 取得所有預設時間
  List<String> get getTimeList => getTime();

  // 更新課程內容
  void updateOrAddCourse(int lecturerId, int courseId, String courseName,
      String date, String time, String courseContent) {
    bool lecturerExists = _coursesByLecturer.any((coursesList) =>
        coursesList.any((course) => course.lecturerId == lecturerId));

    if (lecturerExists) {
      for (var coursesList in _coursesByLecturer) {
        for (var course in coursesList) {
          if (course.lecturerId == lecturerId && course.courseId == courseId) {
            // 更新資料
            int index = coursesList.indexOf(course);
            coursesList[index] = course.copyWith(
              courseName: courseName,
              date: date,
              time: time,
              courseContent: courseContent,
            );
          }
          if (course.lecturerId != lecturerId && course.courseId == courseId) {
            // 删除舊的課程
            coursesList.remove(course);

            // 尋找對應 lecturerId 的列表，如果不存在則新建一個
            var lecturerCoursesList = _coursesByLecturer.firstWhere(
                (list) => list.any((c) => c.lecturerId == lecturerId),
                orElse: () => []);

            if (lecturerCoursesList.isEmpty) {
              lecturerCoursesList = [];
              _coursesByLecturer.add(lecturerCoursesList);
            }

            // 加入更新的課程到對應的 lecturerId 列表
            lecturerCoursesList.add(Course(
              courseId: courseId,
              courseName: courseName,
              lecturerId: lecturerId,
              date: date,
              time: time,
              courseContent: courseContent,
            ));
          }
        }
      }
    } else {
      // 如果 lecturerId 不存在，加入新課程
      _coursesByLecturer.add([
        Course(
          courseId: _globalCourseIdCounter++,
          courseName: courseName,
          lecturerId: lecturerId,
          date: date,
          time: time,
          courseContent: courseContent,
        )
      ]);
    }
    notifyListeners();
  }

  // 建立新課程
  void addNewCourse(int lecturerId, String courseName, String date, String time,
      String courseContent) {
    bool lecturerExists = _coursesByLecturer.any((coursesList) =>
        coursesList.any((course) => course.lecturerId == lecturerId));

    if (lecturerExists) {
      for (var coursesList in _coursesByLecturer) {
        if (coursesList.isNotEmpty &&
            coursesList.first.lecturerId == lecturerId) {
          // 使用課程的 lecturerId 加入新課程
          coursesList.add(Course(
            courseId: _globalCourseIdCounter++,
            courseName: courseName,
            lecturerId: lecturerId,
            date: date,
            time: time,
            courseContent: courseContent,
          ));
        }
      }
    } else {
      // 如果 lecturerId 不存在，則建立新的列表且加入新課程
      _coursesByLecturer.add([
        Course(
          courseId: _globalCourseIdCounter++,
          courseName: courseName,
          lecturerId: lecturerId,
          date: date,
          time: time,
          courseContent: courseContent,
        )
      ]);
    }
  }
}
