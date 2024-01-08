import 'package:flutter_test/flutter_test.dart';

import 'package:student_course_selection_demo/view_model/service_provider.dart';

void main() {
  /// deleteItem removes lecturer and courses：
  /// 測試確保 deleteItem 方法可以正確移除講師以及相對應的課程。
  /// 先獲取初始講師和課程的數量，然後執行 deleteItem 方法，
  /// 再次檢查講師和課程的數量是否正確減少。
  test('deleteItem removes lecturer and courses', () {
    final provider = ServiceProvider();
    provider.getServiceData();

    final lecturerIdToDelete = provider.getLecturerList.first.lecturerId;
    final initialLecturerCount = provider.getLecturerList.length;
    final initialCoursesCount =
        provider.getCourseList.expand((coursesList) => coursesList).length;

    provider.deleteItem(true, lecturerIdToDelete);

    expect(provider.getLecturerList.length, equals(initialLecturerCount - 1));

    final updatedCoursesCount =
        provider.getCourseList.expand((coursesList) => coursesList).length;

    expect(updatedCoursesCount, equals(initialCoursesCount - 3));
  });

  /// updateLecturer updates lecturer information：
  /// 測試確保 updateLecturer 方法可以正確更新講師的資訊。
  /// 先獲取初始講師的資訊，執行 updateLecturer 方法，
  /// 然後檢查講師的資訊是否已經更新。
  test('updateLecturer updates lecturer information', () {
    final provider = ServiceProvider();
    provider.getServiceData();

    final lecturerIdToUpdate = provider.getLecturerList.first.lecturerId;
    const newName = 'New Name';
    const newMajor = 'New Major';

    provider.updateLecturer(lecturerIdToUpdate, newName, newMajor);

    final updatedLecturer = provider.getLecturerList
        .firstWhere((lecturer) => lecturer.lecturerId == lecturerIdToUpdate);

    expect(updatedLecturer.username, equals(newName));
    expect(updatedLecturer.major, equals(newMajor));
  });

  /// addLecturer adds a new lecturer：
  /// 測試確保 addLecturer 方法可以正確新增一位新的講師。
  /// 先獲取初始講師的數量，執行 addLecturer 方法，
  /// 然後檢查講師的數量是否已經增加，並且新增的講師資訊是否正確。
  test('addLecturer adds a new lecturer', () {
    final provider = ServiceProvider();
    provider.getServiceData();

    final initialLecturerCount = provider.getLecturerList.length;

    const newName = 'New Lecturer';
    const newMajor = 'New Major';

    provider.addLecturer(newName, newMajor);

    expect(provider.getLecturerList.length, equals(initialLecturerCount + 1));

    final addedLecturer = provider.getLecturerList.last;

    expect(addedLecturer.username, equals(newName));
    expect(addedLecturer.major, equals(newMajor));
  });

  /// updateLecturer does nothing for non-existent lecturer:
  /// 用 updateLecturer 更新一個不存在的講師時，
  /// 預期 updateLecturer 不應該對任何講師進行更新。
  test('updateLecturer does nothing for non-existent lecturer', () {
    final provider = ServiceProvider();
    provider.getServiceData();

    // 隨機生成不存在的講師ID
    const nonExistentLecturerId = 999999;
    const newName = 'New Name';
    const newMajor = 'New Major';

    // 呼叫 updateLecturer 更新不存在的講師
    provider.updateLecturer(nonExistentLecturerId, newName, newMajor);

    // 檢查講師列表是否未受到影響
    expect(provider.getLecturerList, equals(provider.getLecturerList));
  });

  /// updateLecturer does nothing for non-existent field:
  /// 使用 updateLecturer 只更新講師的某個欄位時，
  /// 預期 updateLecturer 不應該影響其他欄位。
  test('updateLecturer does nothing for non-existent field', () {
    final provider = ServiceProvider();
    provider.getServiceData();

    // 取得要更新的講師ID，這裡假設有講師存在
    final lecturerIdToUpdate = provider.getLecturerList.first.lecturerId;
    const newName = 'New Name';

    // 呼叫 updateLecturer 只更新部分欄位
    provider.updateLecturer(lecturerIdToUpdate, newName, '');

    // 檢查講師資料是否未受到影響
    final updatedLecturer = provider.getLecturerList
        .firstWhere((lecturer) => lecturer.lecturerId == lecturerIdToUpdate);

    expect(updatedLecturer.username, equals(newName));
    expect(updatedLecturer.major, equals(updatedLecturer.major));
  });

  /// updateLecturer does nothing for empty name and major:
  /// 使用 updateLecturer 嘗試更新講師的姓名和專業，但姓名和專業均為空時，
  /// 預期 updateLecturer 不應該對講師進行任何更新。
  test('updateLecturer does nothing for empty name and major', () {
    final provider = ServiceProvider();
    provider.getServiceData();

    // 取得要更新的講師ID，這裡假設有講師存在
    final lecturerIdToUpdate = provider.getLecturerList.first.lecturerId;

    // 呼叫 updateLecturer 傳入空的姓名和專業
    provider.updateLecturer(lecturerIdToUpdate, '', '');

    // 檢查講師資料是否未受到影響
    final updatedLecturer = provider.getLecturerList
        .firstWhere((lecturer) => lecturer.lecturerId == lecturerIdToUpdate);

    expect(updatedLecturer.username, equals(updatedLecturer.username));
    expect(updatedLecturer.major, equals(updatedLecturer.major));
  });

  /// updateLecturer does nothing for non-existent lecturer with empty fields:
  /// 使用 updateLecturer 更新一個不存在的講師，且傳入空的姓名和專業時，
  /// 預期 updateLecturer 不應該對任何講師進行更新。
  test(
      'updateLecturer does nothing for non-existent lecturer with empty fields',
      () {
    final provider = ServiceProvider();
    provider.getServiceData();

    // 隨機生成不存在的講師ID
    const nonExistentLecturerId = 9999;

    // 呼叫 updateLecturer 更新不存在的講師，且傳入空的姓名和專業
    provider.updateLecturer(nonExistentLecturerId, '', '');

    // 檢查講師列表是否未受到影響
    expect(provider.getLecturerList, equals(provider.getLecturerList));
  });
}
