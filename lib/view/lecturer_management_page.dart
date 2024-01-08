import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_course_selection_demo/utilities.dart';
import 'package:student_course_selection_demo/view/dialog/lecturer_edit_dialog.dart';
import 'package:student_course_selection_demo/view/widget/widgets.dart';
import 'package:student_course_selection_demo/view_model/service_provider.dart';
import 'dialog/delete_dialog.dart';

class LecturerManagementPage extends StatefulWidget {
  const LecturerManagementPage({super.key});

  @override
  State<StatefulWidget> createState() => _LecturerManagementPageState();
}

class _LecturerManagementPageState extends State<LecturerManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildFlowAppBar(context, '講師管理'),
      body: Consumer<ServiceProvider>(builder: (context, serviceValue, child) {
        return Container(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: serviceValue.getLecturerList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _lecturerItem(context, serviceValue, index);
              },
            ));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showLecturerEditDialog(context, false, 0);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // 講師 item
  Widget _lecturerItem(
      BuildContext context, ServiceProvider serviceValue, int index) {
    return Container(
        constraints: const BoxConstraints(
          minHeight: 60,
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
              headImageView(
                  setupFaceText(serviceValue.getLecturerList[index].username),
                  40),
              const SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    itemTextStyle(
                        '講師：${serviceValue.getLecturerList[index].username}'),
                    itemTextStyle(
                        '專長：${serviceValue.getLecturerList[index].major}'),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    showLecturerEditDialog(context, true, index);
                  },
                  child: const Text('update')),
              const SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () {
                    showDeleteDialog(
                        context,
                        true,
                        serviceValue.getLecturerList[index].username,
                        serviceValue.getLecturerList[index].lecturerId);
                  },
                  child: const Text('delete')),
            ],
          ),
        ));
  }
}
