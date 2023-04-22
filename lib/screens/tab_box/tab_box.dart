import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/screens/tab_box/widgets/bottom_sheet.dart';
import 'package:todo_app/screens/task/tasks.dart';
import 'package:todo_app/utils/colors.dart';
import '../../utils/icons.dart';
import '../home/home.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];
  int currentScreen = 0;
  int selectedCategory = -1;

  @override
  void initState() {
    screens.add(HomePage());
    screens.add(TasksPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        currentIndex: currentScreen,
        onTap: (value) {
          setState(() {
            currentScreen = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                currentScreen == 0
                    ? MyIcons.selected_home
                    : MyIcons.unselected_home,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(currentScreen == 1
                  ? MyIcons.selected_task
                  : MyIcons.unselected_task),
              label: "")
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(150.r, 50.r),
                    topRight: Radius.elliptical(150.r, 50.r))),
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) => MyBottomSheet(
                  selectedCategory: selectedCategory,
                  onTap: (int index) {
                    setState(() {
                      selectedCategory = index;
                    });
                  },
                ),
              );
            },
          );
        },
        child: Container(
            height: 53,
            width: 53,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29.r),
                boxShadow: [
                  BoxShadow(
                      color: MyColors.plus_color_1.withOpacity(0.4),
                      offset: const Offset(4, 8),
                      blurRadius: 10,
                      spreadRadius: 1)
                ],
                gradient: LinearGradient(
                    colors: [MyColors.plus_color_1, MyColors.plus_color_2])),
            padding: EdgeInsets.all(12.3.r),
            child: SvgPicture.asset(MyIcons.plus)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}