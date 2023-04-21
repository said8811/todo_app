import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/utils/colors.dart';

import '../../../utils/my_text_style.dart';
import '../../app_router.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: () {
        Navigator.pushReplacementNamed(context, RouteName.tabBox);
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                offset: const Offset(4, 8),
                spreadRadius: 2,
                blurRadius: 12,
              )
            ],
            borderRadius: BorderRadius.circular(10.r),
            gradient:
                LinearGradient(colors: [MyColors.C_5DE61A, MyColors.C_39A801])),
        height: 57.h,
        child: Center(
          child: Text(
            "Get Started",
            style: fontRubikW400(appcolor: MyColors.white)
                .copyWith(fontSize: 15.sp),
          ),
        ),
      ),
    );
  }
}
