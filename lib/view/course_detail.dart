import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_course_selection_demo/view_model/course_detail_provider.dart';
import 'widget/widgets.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<StatefulWidget> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildFlowAppBar(context, 'Course detail'),
      body: Center(
          child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(20.0),
              child: Consumer<CourseDetailProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return detailItem(value, index);
                    },
                  );
                },
              ))),
    );
  }

  // 課程資訊項目
  Widget detailItem(CourseDetailProvider value, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('課程介紹',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text('課程名稱：${value.course?.courseName}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text('課程時間：${value.course?.date}, ${value.course?.time}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          height: 1,
          color: Colors.deepPurple,
        ),
        const SizedBox(height: 10),
        const Text('課程內容',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text('${value.course?.courseContent}',
            style: const TextStyle(fontSize: 15)),
      ],
    );
  }

  //
}
