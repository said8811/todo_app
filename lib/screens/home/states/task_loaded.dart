import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/service/sizedbox_extension.dart';
import 'package:todo_app/utils/my_text_style.dart';
import '../../../bloc/task_bloc.dart';
import '../../../service/local_notification.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../widgets/task_widget.dart';

class LoadedTaskWidget extends StatelessWidget {
  List<TaskModel> tasks;
  LoadedTaskWidget({
    super.key,
    required this.tasks,
  });

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
              return TaskWidget(
                onTap: () {
                  !task.isNotify
                      ? LocalNotificationService.localNotificationService
                          .scheduleNotification(
                              id: index,
                              task: task.task,
                              delayedTime: task.date)
                      : LocalNotificationService.localNotificationService
                          .cancelNotificationById(index);
                  context.read<TaskBloc>().add(UpDateTaskEvent(
                      task: task.copyWith(isNotify: !task.isNotify)));
                },
                task: task,
              );
            },
          ),
        )
      ],
    );
  }
}
