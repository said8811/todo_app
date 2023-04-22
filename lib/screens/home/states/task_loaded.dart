import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/bloc/task_bloc/task_bloc.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/service/sizedbox_extension.dart';
import 'package:todo_app/utils/my_text_style.dart';
import '../../../service/local_notification.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../widgets/task_widget.dart';

class LoadedTaskWidget extends StatefulWidget {
  List<TaskModel> tasks;
  TaskModel? notifytask;
  LoadedTaskWidget({
    super.key,
    required this.tasks,
    required this.notifytask,
  });

  @override
  State<LoadedTaskWidget> createState() => _LoadedTaskWidgetState();
}

class _LoadedTaskWidgetState extends State<LoadedTaskWidget> {
  double height = 106;
  String appbar = MyImages.appbarNotify;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.notifytask != null
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(appbar), fit: BoxFit.cover),
                ),
                height: height + 132.h,
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
                          "Today you have ${widget.tasks.length} tasks",
                          style: fontRubikW400(appcolor: MyColors.white)
                              .copyWith(fontSize: 18.sp),
                        ),
                        Container(
                          height: height.h,
                          width: 340.w,
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                              color: MyColors.white.withOpacity(0.31)),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Today Reminder",
                                    style:
                                        fontRubikW500(appcolor: MyColors.white)
                                            .copyWith(fontSize: 20.sp),
                                  ),
                                  20.h.ph,
                                  Text(
                                    "Meeting with client",
                                    style:
                                        fontRubikW400(appcolor: MyColors.white)
                                            .copyWith(fontSize: 11.sp),
                                  ),
                                  8.h.ph,
                                  Text(
                                    "${widget.notifytask?.date.substring(11, 16)}PM",
                                    style:
                                        fontRubikW400(appcolor: MyColors.white)
                                            .copyWith(fontSize: 11.sp),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () => setState(() {
                                      height = 0;
                                      appbar = MyImages.appbar;
                                    }),
                                    child: SvgPicture.asset(
                                      "assets/svg/close.svg",
                                      width: 10.w,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/bigbell.svg",
                                    width: 60.w,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              )
            : Container(
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
                          "Today you have ${widget.tasks.length} tasks",
                          style: fontRubikW400(appcolor: MyColors.white)
                              .copyWith(fontSize: 18.sp),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.r),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => 14.h.ph,
            shrinkWrap: true,
            itemCount: widget.tasks.length,
            itemBuilder: (context, index) {
              final task = widget.tasks[index];
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
