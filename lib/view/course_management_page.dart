import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_course_selection_demo/view/dialog/course_content_dialog.dart';

import '../view_model/service_provider.dart';
import 'dialog/course_edit_dialog.dart';
import 'dialog/delete_dialog.dart';
import 'widget/widgets.dart';

class CourseManagementPage extends StatefulWidget {
  const CourseManagementPage({super.key});

  @override
  State<StatefulWidget> createState() => _CourseManagementPage();
}

class _CourseManagementPage extends State<CourseManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildFlowAppBar(context, '課程管理'),
      body: Consumer<ServiceProvider>(builder: (context, serviceValue, child) {
        return Container(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: serviceValue.allCourses.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showCourseContentDialog(
                        context, serviceValue.allCourses[index].courseContent);
                  },
                  child: _courseItem(context, serviceValue, index),
                );
              },
            ));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCourseEditDialog(context, false, 0);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // 課程 item
  Widget _courseItem(
      BuildContext context, ServiceProvider serviceValue, int index) {
    return Container(
        constraints: const BoxConstraints(
          minHeight: 70,
        ),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 3, left: 10, bottom: 3, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemTextStyle(
                        '課程：${serviceValue.allCourses[index].courseName}'),
                    itemTextStyle(
                        '講師：${serviceValue.getUsernameById(serviceValue.allCourses[index].lecturerId)}'),
                    itemTextStyle(
                        '時間：${serviceValue.allCourses[index].date}, ${serviceValue.allCourses[index].time}'),
                    Text('內容：${serviceValue.allCourses[index].courseContent}',
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.left),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    showCourseEditDialog(context, true, index);
                  },
                  child: const Text('update')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    showDeleteDialog(
                        context,
                        false,
                        serviceValue.allCourses[index].courseName,
                        serviceValue.allCourses[index].courseId);
                  },
                  child: const Text('delete')),
            ],
          ),
        ));
  }
}
