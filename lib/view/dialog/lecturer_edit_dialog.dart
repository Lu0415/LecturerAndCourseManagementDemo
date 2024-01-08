import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/edit_dialog_provider.dart';
import '../../view_model/service_provider.dart';
import '../widget/widgets.dart';

Future showLecturerEditDialog(context, bool isUpdate, int index) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Dialog(
                insetPadding: const EdgeInsets.all(0),
                child: SizedBox(
                  width: 260,
                  height: 370,
                  child: Consumer2<ServiceProvider, EditDialogProvider>(
                    builder: (context, serviceValue, editValue, child) {
                      return LecturerEditDialog(
                          isUpdate: isUpdate,
                          index: index,
                          serviceValue: serviceValue, 
                          editValue: editValue,);
                    },
                  ),
                ),
              )));
}

class LecturerEditDialog extends StatefulWidget {
  final bool isUpdate;
  final int index;
  final ServiceProvider serviceValue;
  final EditDialogProvider editValue;

  const LecturerEditDialog({
    super.key,
    required this.isUpdate,
    required this.index,
    required this.serviceValue,
    required this.editValue,
  });

  @override
  State<StatefulWidget> createState() => _LecturerEditDialogState();
}

class _LecturerEditDialogState extends State<LecturerEditDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController majorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      nameController.text =
          widget.serviceValue.getLecturerList[widget.index].username;
      majorController.text =
          widget.serviceValue.getLecturerList[widget.index].major;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _passDataToProvider();
          });
    }

    nameController.addListener(_nameControllerListener);
    majorController.addListener(_expertiseControllerListener);
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
                        widget.isUpdate ? '修改講師資訊' : '新增講師',
                        style: dialogTextStyle(18, true),
                      ),
                    )),
                Container(
                  width: 210,
                  height: 1,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 20),
                Text(
                  '講師姓名',
                  style: dialogTextStyle(16, false),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 210,
                  child: TextField(
                    controller: nameController,
                    obscureText: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: '請輸入講師姓名'),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  '講師專長',
                  style: dialogTextStyle(16, false),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 210,
                  child: TextField(
                    controller: majorController,
                    obscureText: false,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: '請輸入講師專長'),
                  ),
                ),
                const SizedBox(height: 25),
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
                              onPressed: widget.editValue.isLecturerEditDataIsNotEmpty
                                  ? () {
                                      if (widget.isUpdate) {
                                        widget.serviceValue.updateLecturer(
                                            widget
                                                .serviceValue
                                                .getLecturerList[widget.index]
                                                .lecturerId,
                                            nameController.text,
                                            majorController.text);
                                      } else {
                                        widget.serviceValue.addLecturer(
                                            nameController.text,
                                            majorController.text);
                                      }
                                      Navigator.of(context).pop();
                                    }
                                  : null,
                              child: const Text('確定')),
                        ],
                      ),
                ),
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
    provider.checkLecturerEditDataIsNotEmpty(
        nameController.text, majorController.text);
  }

  @override
  void dispose() {
    nameController.removeListener(_nameControllerListener);
    majorController.removeListener(_expertiseControllerListener);

    nameController.dispose();
    majorController.dispose();
    super.dispose();
  }
}
