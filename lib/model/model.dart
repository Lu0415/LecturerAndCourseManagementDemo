// Model Class

// 課程 
class Course {
  final int courseId; // 課程 id
  final String courseName; // 課程名稱
  final int lecturerId; // 講師 id
  final String date; // 日期
  final String time; // 時間
  final String courseContent; // 課程內容

  Course({
    required this.courseId,
    required this.courseName,
    required this.lecturerId,
    required this.date,
    required this.time,
    required this.courseContent,
  });

  Course copyWith({
    int? courseId,
    String? courseName,
    int? lecturerId,
    String? date,
    String? time,
    String? courseContent,
  }) {
    return Course(
      courseId: courseId ?? this.courseId,
      courseName: courseName ?? this.courseName,
      lecturerId: lecturerId ?? this.lecturerId,
      date: date ?? this.date,
      time: time ?? this.time,
      courseContent: courseContent ?? this.courseContent,
    );
  }
}

// 講師
class Lecturer {
  final int lecturerId; // 講師 id
  final String username; // 講師姓名
  final String password; // 講師密碼
  final String major; // 講師專長

  Lecturer({required this.lecturerId, required this.username, required this.password, required this.major});

  Lecturer copyWith({
    int? lecturerId,
    String? username,
    String? password,
    String? major,
  }) {
    return Lecturer(
      lecturerId: lecturerId ?? this.lecturerId,
      username: username ?? this.username,
      password: password ?? this.password,
      major: major ?? this.major,
    );
  }
}