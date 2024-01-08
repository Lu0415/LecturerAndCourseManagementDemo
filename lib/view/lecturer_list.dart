import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_course_selection_demo/view_model/course_detail_provider.dart';
import 'package:student_course_selection_demo/view_model/lecturer_provider.dart';
import 'package:student_course_selection_demo/view_model/service_provider.dart';
import '../utilities.dart';
import 'widget/widgets.dart';

class LecturerListPage extends StatefulWidget {
  const LecturerListPage({super.key});

  @override
  State<StatefulWidget> createState() => _LecturerListPageState();
}

class _LecturerListPageState extends State<LecturerListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildFlowAppBar(context, 'Lecturer list'),
      body: Center(child: Consumer2<ServiceProvider, LecturerProvider>(
        builder: (context, serviceValue, lecturerValue, child) {
          // 設置相關資料
          lecturerValue.setExpansionTileData(
              serviceValue.getLecturerList, serviceValue.getCourseList);

          // 設置講師項目
          return Container(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: lecturerValue.listCount,
              itemBuilder: (context, index) {
                // 設置 ExpansionTile
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ExpansionTile(
                    shape: const Border(),
                    leading: headImageView(
                        lecturerValue.getFaceImageText(index), 40),
                    title: Text(lecturerValue.lecturers[index].username),
                    subtitle: Text(lecturerValue.lecturers[index].major),
                    trailing: Icon(
                      lecturerValue.expansionTileStates[index]
                          ? Icons.remove
                          : Icons.add,
                    ),
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 1,
                            color: Colors.deepPurple,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                          ),
                          _listTileItems(context, lecturerValue, index),
                        ],
                      )
                    ],
                    onExpansionChanged: (bool expanded) {
                      lecturerValue.changeExpansionTileStates(index);
                    },
                  ),
                );
              },
            ),
          );
        },
      )),
    );
  }

  // 設置課程項目
  ListView _listTileItems(
      BuildContext context, LecturerProvider provider, int listIndex) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: provider.getCoursesCount(listIndex),
      itemBuilder: (context, tileIndex) {
        return Consumer<CourseDetailProvider>(
          builder: (context, courseDetailValue, child) {
            return ListTile(
              leading: const Icon(
                Icons.calendar_month,
              ),
              title: Text(provider.getCourse(listIndex, tileIndex).courseName),
              subtitle: Text(provider.getDateTime(listIndex, tileIndex)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                courseDetailValue
                    .setDetail(provider.getCourse(listIndex, tileIndex));

                Navigator.of(context).pushNamed(courseDetail);
              },
            );
          },
        );
      },
    );
  }
}
