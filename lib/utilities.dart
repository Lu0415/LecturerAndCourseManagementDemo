import 'dart:math';
import 'package:flutter/material.dart';

// routes
const routeHome = '/';
const lecturerList = '/lecturer_list';
const courseDetail = '/course_detail';
const lecturerManagement = '/lecturer_management';
const courseManagement = '/courseManagement';

// 隨機顏色
Color randomColor() {
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

const List<String> _week = ['星期一', '星期二', '星期三', '星期四', '星期五'];
const List<String> _time = [
  '08:00-09:00',
  '09:00-10:00',
  '10:00-1100',
  '11:00-12:00',
  '13:00-1400',
  '14:00-15:00',
  '15:00-16:00',
  '16:00-17:00'
];
const List<String> _sports = [
  'Soccer',
  'Basketball',
  'Baseball',
  'Volleyball',
  'Swimming',
  'Track and Field',
  'Badminton',
  'Tennis',
  'Golf',
  'Skateboarding',
  'Ice Hockey',
  'Rugby',
  'Table Tennis',
  'Softball',
  'Diving',
];

// 取得隨機星期幾
String getRandomDate() {
  return _week[Random().nextInt(_week.length)];
}

List<String> getDate() {
  return _week;
}

// 取得隨機預設時段
String getRandomTime() {
  return _time[Random().nextInt(_time.length)];
}

List<String> getTime() {
  return _time;
}

// 取得隨機運動項目
String getRandomSport() {
  return _sports[Random().nextInt(_sports.length)];
}

// 姓名擷取
String setupFaceText(String name) {
  if (name.length > 3) {
    return name.substring(0, 3);
  } else {
    return name[0];
  }
}
