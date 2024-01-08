import 'package:flutter/material.dart';
import '../widget/widgets.dart';

Future showCourseContentDialog(context, String content) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Dialog(
                insetPadding: const EdgeInsets.all(0),
                child: SizedBox(
                  width: 300,
                  height: 500,
                  child: ContentDialog(content: content),
                ),
              )));
}

class ContentDialog extends StatefulWidget {
  final String content;

  const ContentDialog({
    super.key,
    required this.content,
  });

  @override
  State<StatefulWidget> createState() => _ContentDialogState();
}

class _ContentDialogState extends State<ContentDialog> {
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
                      '課程內容',
                      style: dialogTextStyle(18, true),
                    ),
                  )),
              Container(
                width: 260,
                height: 1,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 350,
                width: 260,
                child: SingleChildScrollView(
                  child: Text(
                    widget.content,
                    style: dialogTextStyle(14, false),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('關閉')),
            ],
          ),
        ),
      ),
    );
  }
}
