import 'package:flutter/rendering.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/icons.dart';

class TaskCategory {
  String imgPath;
  String name;
  Color color;
  int colorInt;

  TaskCategory(
      {required this.imgPath,
      required this.name,
      required this.color,
      required this.colorInt});

  static List<TaskCategory> categories = [
    TaskCategory(
        imgPath: MyIcons.person,
        name: "Personal",
        color: MyColors.personal,
        colorInt: 0xFFFFD506),
    TaskCategory(
        imgPath: MyIcons.work,
        name: "Work",
        color: MyColors.work,
        colorInt: 0xFF1ED102),
    TaskCategory(
        imgPath: MyIcons.meeting,
        name: "Meeting",
        color: MyColors.meeting,
        colorInt: 0xFFD10263),
    TaskCategory(
        imgPath: MyIcons.shopping,
        name: "Shopping",
        color: MyColors.shopping,
        colorInt: 0xFFF29130),
    TaskCategory(
        imgPath: MyIcons.party,
        name: "Party",
        color: MyColors.party,
        colorInt: 0xFF9BFFF85),
    TaskCategory(
        imgPath: MyIcons.study,
        name: "Study",
        color: MyColors.study,
        colorInt: 0xFFF59BFF),
  ];
}
