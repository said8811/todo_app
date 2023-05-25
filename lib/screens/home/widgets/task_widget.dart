import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/service/sizedbox_extension.dart';

import '../../../bloc/task_bloc/task_bloc.dart';
import '../../../data/models/tasks_category_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/icons.dart';
import '../../../utils/my_text_style.dart';
import '../../tab_box/widgets/bottom_sheet.dart';

class TaskWidget extends StatefulWidget {
  final VoidCallback onTap;
  final TaskModel task;
  const TaskWidget({super.key, required this.task, required this.onTap});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.28,
        motion: const ScrollMotion(),
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () {
              selectedCategory = TaskCategory.mymap[widget.task.category];
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(150.r, 50.r),
                        topRight: Radius.elliptical(150.r, 50.r))),
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: MyBottomSheet(
                        selectedCategory: selectedCategory,
                        onTap: (int index) {
                          setState(() {
                            selectedCategory = index;
                          });
                        },
                        initialText: widget.task.task,
                        update: true,
                        taskday: widget.task.date,
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 35.h,
              width: 35.w,
              margin: EdgeInsets.only(
                left: 10.r,
              ),
              decoration: BoxDecoration(
                  color: MyColors.C_5F87E7.withOpacity(0.36),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Center(
                child: SvgPicture.asset(MyIcons.edit),
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: () {
              context.read<TaskBloc>().add(DeleteTaskEvent(task: widget.task));
            },
            child: Container(
              height: 35.h,
              width: 35.w,
              margin: EdgeInsets.only(left: 8.r),
              decoration: BoxDecoration(
                  color: MyColors.C_FFCFCF.withOpacity(0.36),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Center(
                child: SvgPicture.asset(MyIcons.trash),
              ),
            ),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.r),
        margin: EdgeInsets.only(bottom: 14.r),
        height: 55.h,
        decoration: BoxDecoration(
            color: MyColors.white,
            gradient: LinearGradient(
                stops: const [0.02, 0.02],
                colors: [Color(widget.task.color), MyColors.white]),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(4, 8),
                  color: Colors.grey.withOpacity(0.36),
                  blurRadius: 8,
                  spreadRadius: 1.5)
            ]),
        child: Row(
          children: [
            10.w.pw,
            InkWell(
              borderRadius: BorderRadius.circular(9.r),
              onTap: () {
                context.read<TaskBloc>().add(UpDateTaskEvent(
                    task: widget.task.copyWith(isDone: !widget.task.isDone)));
              },
              child: Container(
                width: 18.w,
                height: 18.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.r),
                    border: Border.all(
                        color: widget.task.isDone
                            ? Colors.white
                            : MyColors.C_DADADA)),
                child: widget.task.isDone
                    ? SvgPicture.asset(MyIcons.done)
                    : const SizedBox(),
              ),
            ),
            8.w.pw,
            Text(
              "${widget.task.date.substring(11, 16)} AM",
              style: fontRubikW400(appcolor: MyColors.C_C6C6C8)
                  .copyWith(fontSize: 11.sp),
            ),
            8.w.pw,
            Text(
              widget.task.task.length > 27
                  ? widget.task.task.substring(0, 27)
                  : widget.task.task,
              style: fontRubikW500(
                      appcolor: widget.task.isDone
                          ? MyColors.C_D9D9D9
                          : MyColors.C_554E8F)
                  .copyWith(
                      fontSize: 14.sp,
                      decoration: widget.task.isDone
                          ? TextDecoration.underline
                          : TextDecoration.none),
            ),
            const Spacer(),
            InkWell(
              onTap: widget.onTap,
              child: SvgPicture.asset(
                  widget.task.isNotify ? MyIcons.bell2 : MyIcons.bell),
            ),
          ],
        ),
      ),
    );
  }
}
