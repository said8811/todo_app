import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/service/sizedbox_extension.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/my_text_style.dart';

class EmptyTaskList extends StatelessWidget {
  const EmptyTaskList({super.key});

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
                    "Today you have no tasks",
                    style: fontRubikW400(appcolor: MyColors.white)
                        .copyWith(fontSize: 18.sp),
                  )
                ],
              ),
            )
          ]),
        ),
        150.h.ph,
        Center(
          child: SvgPicture.asset(MyImages.emptyTasks),
        ),
        70.h.ph,
        Text(
          "No tasks",
          style: fontRubikW500(appcolor: MyColors.C_554E8F)
              .copyWith(fontSize: 22.sp),
        )
      ],
    );
  }
}
