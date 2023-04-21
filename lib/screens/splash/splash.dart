import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/screens/splash/widgets/container.dart';
import 'package:todo_app/utils/colors.dart';

import '../../utils/images.dart';
import '../../utils/my_text_style.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 57.r),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 162.h),
            SvgPicture.asset(
              MyImages.note,
            ),
            SizedBox(height: 103.h),
            Text(
              "Reminders made simple",
              style: fontRubikW500(appcolor: MyColors.C_554E8F)
                  .copyWith(fontSize: 22.sp),
            ),
            SizedBox(height: 171.h),
            const StartButton(),
          ],
        ),
      ),
    );
  }
}
