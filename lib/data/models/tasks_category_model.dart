import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/icons.dart';

class TaskCategory {
  String imgPath;
  String name;
  Color color;
  int colorInt;
  int count;

  TaskCategory(
      {required this.imgPath,
      required this.name,
      required this.color,
      required this.colorInt,
      required this.count});

  static List<TaskCategory> categories = [
    TaskCategory(
        imgPath: MyIcons.person,
        name: "Personal",
        color: MyColors.personal,
        colorInt: 0xFFFFD506,
        count: 0),
    TaskCategory(
        imgPath: MyIcons.work,
        name: "Work",
        color: MyColors.work,
        colorInt: 0xFF1ED102,
        count: 0),
    TaskCategory(
        imgPath: MyIcons.meeting,
        name: "Meeting",
        color: MyColors.meeting,
        colorInt: 0xFFD10263,
        count: 0),
    TaskCategory(
        imgPath: MyIcons.shopping,
        name: "Shopping",
        color: MyColors.shopping,
        colorInt: 0xFFF29130,
        count: 0),
    TaskCategory(
        imgPath: MyIcons.party,
        name: "Party",
        color: MyColors.party,
        count: 0,
        colorInt: 0xFF9BFFF85),
    TaskCategory(
        imgPath: MyIcons.study,
        name: "Study",
        color: MyColors.study,
        colorInt: 0xFFF59BFF,
        count: 0),
  ];
  static Map mymap = {
    "Personal": 0,
    "Work": 1,
    "Meeting": 2,
    "Shopping": 3,
    "Party": 4,
    "Study": 5,
  };
  static Map counts = {
    "Personal": 0,
    "Work": 0,
    "Meeting": 0,
    "Shopping": 0,
    "Party": 0,
    "Study": 0,
  };
}
