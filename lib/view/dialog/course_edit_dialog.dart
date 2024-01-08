import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/edit_dialog_provider.dart';
import '../../view_model/service_provider.dart';
import '../widget/widgets.dart';

Future showCourseEditDialog(context, bool isUpdate, int index) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Dialog(
                insetPadding: const EdgeInsets.all(0),
                child: SizedBox(
                  width: 260,
                  height: 500,
                  child: Consumer2<ServiceProvider, EditDialogProvider>(
                    builder: (context, serviceValue, editValue, child) {
                      return CourseEditDialog(
                        isUpdate: isUpdate,
                        index: index,
                        serviceValue: serviceValue,
                        editValue: editValue,
                      );
                    },
                  ),
                ),
              )));
}

class CourseEditDialog extends StatefulWidget {
  final bool isUpdate;
  final int index;
  final ServiceProvider serviceValue;
  final EditDialogProvider editValue;
  final double _width = 210;

  const CourseEditDialog({
    super.key,
    required this.isUpdate,
    required this.index,
    required this.serviceValue,
    required this.editValue,
  });

  @override
  State<StatefulWidget> createState() => _CourseEditDialogState();
}

class _CourseEditDialogState extends State<CourseEditDialog> {
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseContentController = TextEditingController();

  String _lecturerName = '';
  String _date = '';
  String _time = '';

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      courseNameController.text =
          widget.serviceValue.allCourses[widget.index].courseName;
      courseContentController.text =
          widget.serviceValue.allCourses[widget.index].courseContent;
      _lecturerName = widget.serviceValue.getUsernameById(
          widget.serviceValue.allCourses[widget.index].lecturerId);
      _date = widget.serviceValue.allCourses[widget.index].date;
      _time = widget.serviceValue.allCourses[widget.index].time;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _passDataToProvider();
    });

    courseNameController.addListener(_nameControllerListener);
    courseContentController.addListener(_expertiseControllerListener);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
            color: Colors.grey[850],
            child: Column(
              children: [
                SizedBox(
                    height: 64,
                    child: Center(
                      child: Text(
                        widget.isUpdate ? '修改課程資訊' : '新增課程',
                        style: dialogTextStyle(18, true),
                      ),
                    )),
                Container(
                  width: widget._width,
                  height: 1,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 20),
                Text(
                  '課程名稱',
                  style: dialogTextStyle(14, false),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: widget._width,
                  child:
                      editDialogTextField(courseNameController, '請輸入課程名稱', 1),
                ),
                const SizedBox(height: 20),
                Text(
                  '選擇講師及課程時間',
                  style: dialogTextStyle(14, false),
                ),
                const SizedBox(height: 5),
                MyDropdownMenu(
                  width: widget._width,
                  isUpdate: widget.isUpdate,
                  lecturerNames: widget.serviceValue.getLecturerNames,
                  index: widget.index,
                  fontSize: 12,
                  onItemSelected: (value) {
                    _lecturerName = value;
                    _passDataToProvider();
                  },
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyDropdownMenu(
                      width: 90,
                      isUpdate: widget.isUpdate,
                      lecturerNames: widget.serviceValue.getDateList,
                      index: widget.index,
                      fontSize: 10,
                      onItemSelected: (value) {
                        _date = value;
                        _passDataToProvider();
                      },
                    ),
                    const SizedBox(width: 5),
                    MyDropdownMenu(
                      width: 120,
                      isUpdate: widget.isUpdate,
                      lecturerNames: widget.serviceValue.getTimeList,
                      index: widget.index,
                      fontSize: 10,
                      onItemSelected: (value) {
                        _time = value;
                        _passDataToProvider();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  '課程內容',
                  style: dialogTextStyle(14, false),
                ),
                const SizedBox(height: 5),
                SizedBox(
                    width: widget._width,
                    child: editDialogTextField(
                        courseContentController, '請輸入課程內容', 4)),
                const Spacer(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('取消')),
                      const SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: widget.editValue.isCourseEditDataIsNotEmpty
                              ? () {
                                  if (widget.isUpdate) {
                                    widget.serviceValue.updateOrAddCourse(
                                        widget.serviceValue
                                            .getLecturerIdByName(_lecturerName),
                                        widget.isUpdate
                                            ? widget
                                                .serviceValue
                                                .allCourses[widget.index]
                                                .courseId
                                            : -1,
                                        courseNameController.text,
                                        _date,
                                        _time,
                                        courseContentController.text);
                                  } else {
                                    widget.serviceValue.addNewCourse(
                                        widget.serviceValue
                                            .getLecturerIdByName(_lecturerName),
                                        courseNameController.text,
                                        _date,
                                        _time,
                                        courseContentController.text);
                                  }

                                  Navigator.of(context).pop();
                                }
                              : null,
                          child: const Text('確定')),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            )),
      ),
    );
  }

  // 監聽 name TextField
  void _nameControllerListener() {
    _passDataToProvider();
  }

  // 監聽 major TextField
  void _expertiseControllerListener() {
    _passDataToProvider();
  }

  // 檢查按鈕狀態
  void _passDataToProvider() {
    var provider = Provider.of<EditDialogProvider>(context, listen: false);
    provider.checkCourseEditDataIsNotEmpty(_lecturerName,
        courseNameController.text, _date, _time, courseContentController.text);
  }

  @override
  void dispose() {
    courseNameController.removeListener(_nameControllerListener);
    courseContentController.removeListener(_expertiseControllerListener);

    courseNameController.dispose();
    courseContentController.dispose();
    super.dispose();
  }
}
