import 'package:flutter/material.dart';
import '../../utilities.dart';

// AppBar
PreferredSizeWidget buildFlowAppBar(BuildContext context, String title) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.chevron_left),
    ),
    title: Text(title),
  );
}

// 製作頭像
Widget headImageView(String name, double size) {
  return Container(
    alignment: Alignment.center,
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: randomColor(),
      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
    ),
    child: Text(
      name,
      style: TextStyle(fontSize: size / 3),
    ),
  );
}

// 項目文字樣式
Text itemTextStyle(String str) {
  return Text(str, softWrap: true, maxLines: 2, textAlign: TextAlign.left);
}

// dialog 文字樣式
TextStyle dialogTextStyle(double fontSize, bool isBold) {
  return TextStyle(
      color: Colors.deepPurple,
      fontSize: fontSize,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal);
}

// Edit dialog TextField Style
TextField editDialogTextField(TextEditingController controller, String hint, int maxLines) {
  return TextField(
    controller: controller,
    obscureText: false,
    decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        border: const OutlineInputBorder(),
        hintText: hint),
    style: const TextStyle(fontSize: 12),
    maxLines: maxLines,
    minLines: 1,
  );
}

// 下拉選單
class MyDropdownMenu extends StatelessWidget {
  final double width;
  final bool isUpdate;
  final List<String> lecturerNames;
  final int index;
  final double fontSize;
  final Function(String)? onItemSelected; // 回调函数

  const MyDropdownMenu({
    super.key,
    required this.width,
    required this.isUpdate,
    required this.lecturerNames,
    required this.index,
    required this.fontSize,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: width,
      textStyle: TextStyle(fontSize: fontSize),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        constraints: const BoxConstraints(maxHeight: 40),
        isDense: true,
      ),
      menuStyle: MenuStyle(
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
      ),
      initialSelection: isUpdate ? lecturerNames[index] : null,
      onSelected: (value) {
        // 在这里调用回调函数传递选中的值
        if (onItemSelected != null) {
          onItemSelected!(value!);
        }
      },
      dropdownMenuEntries:
          lecturerNames.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
        );
      }).toList(),
    );
  }
}
