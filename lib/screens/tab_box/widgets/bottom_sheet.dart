import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/service/sizedbox_extension.dart';
import 'package:todo_app/utils/colors.dart';
import '../../../data/models/tasks_category_model.dart';
import '../../../utils/icons.dart';
import '../../../utils/my_text_style.dart';

class MyBottomSheet extends StatefulWidget {
  int selectedCategory;
  Function onTap;
  String initialText;
  bool update;
  String taskday;
  MyBottomSheet(
      {super.key,
      required this.selectedCategory,
      required this.onTap,
      this.initialText = "",
      this.update = false,
      this.taskday = ''});

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  DateTime? taskDay;
  TimeOfDay? taskTime;
  String taskName = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Positioned(
          top: -20,
          child: InkWell(
            borderRadius: BorderRadius.circular(29.r),
            onTap: () {
              Navigator.pop(context);
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
                    gradient: LinearGradient(colors: [
                      MyColors.plus_color_1,
                      MyColors.plus_color_2
                    ])),
                padding: EdgeInsets.all(15.3.r),
                child: SvgPicture.asset(MyIcons.close)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 45).r,
          height: 400.h,
          width: double.infinity,
          padding: EdgeInsets.only(left: 20.r, right: 20.r, bottom: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.update ? "Update task" : "Add new task",
                  style: fontRubikW500(appcolor: MyColors.C_404040)
                      .copyWith(fontSize: 13.sp),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  taskName = value;
                },
                initialValue: widget.initialText,
                style: fontRubikW400(appcolor: MyColors.C_373737),
                cursorHeight: 28.h,
                cursorColor: MyColors.black,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
              8.h.ph,
              Divider(
                color: MyColors.C_CFCFCF,
              ),
              14.h.ph,
              Container(
                decoration: const BoxDecoration(),
                height: 30.h,
                child: ListView.separated(
                  separatorBuilder: (context, index) => 10.w.pw,
                  shrinkWrap: true,
                  itemCount: TaskCategory.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = TaskCategory.categories[index];
                    return InkWell(
                      onTap: () => widget.onTap.call(index),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.r),
                        decoration: BoxDecoration(
                          color: index == widget.selectedCategory
                              ? category.color
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        height: 30,
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              index == widget.selectedCategory
                                  ? 0.pw
                                  : Container(
                                      width: 10.w,
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          color: category.color),
                                    ),
                              5.w.pw,
                              Text(
                                category.name,
                                style: fontRubikW400(
                                        appcolor:
                                            index == widget.selectedCategory
                                                ? MyColors.white
                                                : MyColors.C_8E8E8E)
                                    .copyWith(fontSize: 15.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              12.h.ph,
              Divider(
                color: MyColors.C_CFCFCF,
              ),
              28.h.ph,
              Row(
                children: widget.update
                    ? []
                    : [
                        Text(
                          "Choose Date",
                          style: fontRubikW400(appcolor: MyColors.black)
                              .copyWith(fontSize: 13.sp),
                        ),
                        0.w.pw,
                        IconButton(
                            padding: EdgeInsets.all(0.r),
                            onPressed: () async {
                              print(taskDay);
                              taskDay = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2300),
                              );
                              // ignore: use_build_context_synchronously
                              taskTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              taskDay = DateTime(
                                taskDay?.year ?? 0000,
                                taskDay?.month ?? 00,
                                taskDay?.day ?? 00,
                                taskTime?.hour ?? 00,
                                taskTime?.minute ?? 00,
                              );
                            },
                            icon: SvgPicture.asset(MyIcons.downward))
                      ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.r),
                child: InkWell(
                  onTap: () {
                    final category =
                        TaskCategory.categories[widget.selectedCategory];
                    TaskModel task = TaskModel(
                      task: taskName,
                      category: category.name,
                      color: category.colorInt,
                      isDone: false,
                      isNotify: false,
                      date: widget.update ? widget.taskday : taskDay.toString(),
                      count: 1,
                    );
                    widget.update
                        ? context
                            .read<TaskBloc>()
                            .add(UpDateTaskEvent(task: task))
                        : context
                            .read<TaskBloc>()
                            .add(AddTaskEvent(task: task));
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 53.h,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.36),
                              offset: const Offset(4, 8),
                              spreadRadius: 1,
                              blurRadius: 4)
                        ],
                        borderRadius: BorderRadius.circular(5.r),
                        gradient: LinearGradient(
                            colors: [MyColors.primary_1, MyColors.primary_2])),
                    child: Center(
                      child: Text(
                        widget.update ? "Update task" : "Add task",
                        style: fontRubikW500(appcolor: MyColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
