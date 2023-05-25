import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/data/models/tasks_category_model.dart';
import 'package:todo_app/service/sizedbox_extension.dart';

import '../../../utils/colors.dart';
import '../../../utils/my_text_style.dart';

class CategoryWidget extends StatelessWidget {
  final TaskCategory category;
  const CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
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
  }
}
