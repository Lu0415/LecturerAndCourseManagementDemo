import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_course_selection_demo/view_model/service_provider.dart';
import '../widget/widgets.dart';

Future showDeleteDialog(
    context, bool isLecturer, String deleteItemName, int itemId) {
      
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Dialog(
                insetPadding: const EdgeInsets.all(0),
                child: SizedBox(
                  width: 260,
                  height: 260,
                  child: DeleteDialog(
                      isLecturer: isLecturer,
                      deleteItemName: deleteItemName,
                      itemId: itemId),
                ),
              )));
}

class DeleteDialog extends StatefulWidget {
  final bool isLecturer;
  final String deleteItemName;
  final int itemId;

  const DeleteDialog(
      {super.key,
      required this.isLecturer,
      required this.deleteItemName,
      required this.itemId});

  @override
  State<StatefulWidget> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          color: Colors.white70,
          child: Column(
            children: [
              SizedBox(
                  height: 64,
                  child: Center(
                    child: Text(
                      '刪除通知',
                      style: dialogTextStyle(18, true),
                    ),
                  )),
              Container(
                width: 210,
                height: 1,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 43),
              Text(
                '即將刪除 ${widget.deleteItemName} ${widget.isLecturer ? '講師' : '課程'}',
                style: dialogTextStyle(14, false),
              ),
              Text(
                '${widget.isLecturer ? '講師課程也會刪除，' : ''}確定刪除？',
                style: dialogTextStyle(14, false),
              ),
              const SizedBox(height: 43),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Consumer<ServiceProvider>(
                  builder: (context, serviceValue, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('取消')),
                        const SizedBox(width: 20),
                        ElevatedButton(
                            onPressed: () {
                              serviceValue.deleteItem(
                                  widget.isLecturer, widget.itemId);
                              Navigator.of(context).pop();
                            },
                            child: const Text('確定')),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
