import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/models/tasks_category_model.dart';
import 'package:todo_app/service/sizedbox_extension.dart';
import 'package:todo_app/utils/my_text_style.dart';

import '../../../bloc/task_bloc.dart';
import '../../../service/local_notification.dart';
import '../../../utils/colors.dart';
import '../../../utils/icons.dart';
import '../../../utils/images.dart';
import '../../tab_box/widgets/bottom_sheet.dart';

class LoadedTaskWidget extends StatelessWidget {
  List<TaskModel> tasks;
  LoadedTaskWidget({
    super.key,
    required this.tasks,
  });
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(MyImages.appbar), fit: BoxFit.cover),
          ),
          height: 106.h,
          width: double.infinity,
          child: Stack(children: [
            Positioned(
              top: 32.h,
              left: 18.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello Brenda!",
                    style: fontRubikW400(appcolor: MyColors.white)
                        .copyWith(fontSize: 18.sp),
                  ),
                  8.h.ph,
                  Text(
                    "Today you have ${tasks.length} tasks",
                    style: fontRubikW400(appcolor: MyColors.white)
                        .copyWith(fontSize: 18.sp),
                  )
                ],
              ),
            )
          ]),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.r),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => 14.h.ph,
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.28,
                  motion: const ScrollMotion(),
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20.r),
                      onTap: () {
                        // selectedCategory =
                        //     TaskCategory.mymap['${task.category}'];
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
                                initialText: task.task,
                                update: true,
                                taskday: task.date,
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 35.h,
                        width: 35.w,
                        margin: EdgeInsets.only(left: 10.r),
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
                        context
                            .read<TaskBloc>()
                            .add(DeleteTaskEvent(task: task));
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
                  height: 55.h,
                  decoration: BoxDecoration(
                      color: MyColors.white,
                      gradient: LinearGradient(
                          stops: const [0.02, 0.02],
                          colors: [Color(tasks[index].color), MyColors.white]),
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
                              task:
                                  tasks[index].copyWith(isDone: !task.isDone)));
                        },
                        child: Container(
                          width: 18.w,
                          height: 18.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.r),
                              border: Border.all(
                                  color: task.isDone
                                      ? Colors.white
                                      : MyColors.C_DADADA)),
                          child: task.isDone
                              ? SvgPicture.asset(MyIcons.done)
                              : const SizedBox(),
                        ),
                      ),
                      11.w.pw,
                      Text(
                        "${task.date.substring(11, 16)} AM",
                        style: fontRubikW400(appcolor: MyColors.C_C6C6C8)
                            .copyWith(fontSize: 11.sp),
                      ),
                      11.w.pw,
                      Text(
                        task.task,
                        style: fontRubikW500(
                                appcolor: task.isDone
                                    ? MyColors.C_D9D9D9
                                    : MyColors.C_554E8F)
                            .copyWith(
                                fontSize: 14.sp,
                                decoration: task.isDone
                                    ? TextDecoration.underline
                                    : TextDecoration.none),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          print(task.date);
                          print(DateTime.now());
                          !task.isNotify
                              ? LocalNotificationService
                                  .localNotificationService
                                  .scheduleNotification(
                                      id: index,
                                      task: task.task,
                                      delayedTime: task.date)
                              : LocalNotificationService
                                  .localNotificationService
                                  .cancelNotificationById(index);
                          context.read<TaskBloc>().add(UpDateTaskEvent(
                              task: task.copyWith(isNotify: !task.isNotify)));
                        },
                        child: SvgPicture.asset(
                            task.isNotify ? MyIcons.bell2 : MyIcons.bell),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
