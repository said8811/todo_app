import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/service/sizedbox_extension.dart';
import '../../data/models/tasks_category_model.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/my_text_style.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
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
            40.h.ph,
            GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              itemCount: TaskCategory.categories.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 180),
              itemBuilder: (context, index) {
                TaskCategory category = TaskCategory.categories[index];
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.5,
                            blurRadius: 8,
                            offset: Offset(4, 8))
                      ]),
                  child: Column(
                    children: [
                      20.h.ph,
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(33),
                            color: category.color.withOpacity(0.35)),
                        child: Center(
                          child: SvgPicture.asset(category.imgPath),
                        ),
                      ),
                      Text(
                        category.name,
                        style: fontRubikW500(appcolor: MyColors.C_686868),
                      ),
                      30.h.ph,
                      Text(
                        "${TaskCategory.counts[category.name]} tasks",
                        style: fontRubikW400(appcolor: MyColors.C_A1A1A1)
                            .copyWith(fontSize: 10.sp),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
