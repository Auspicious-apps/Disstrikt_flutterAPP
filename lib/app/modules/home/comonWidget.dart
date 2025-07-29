import 'package:disstrikt/app/core/widget/asset_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/values/app_colors.dart';
import '../../core/values/app_values.dart';
import '../../core/widget/text_view.dart';

Widget buildCommonRow({
  required icon,
  required String name,
  required VoidCallback onTap,
  required bool isDivider,
}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Column(
      children: [
        Container(
          height: height_40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AssetImageWidget(icon),
              const SizedBox(width: 20),
              Expanded(
                child: TextView(
                  text: name.tr, // Assuming name is a translation key
                  textAlign: TextAlign.start,
                  textStyle: const TextStyle(
                    color: AppColors.blackColor,
                    fontFamily: "Kodchasan",
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ).marginOnly(right: margin_50, left: margin_20),
        isDivider
            ? Divider(
                color: AppColors.buttonColor,
              ).marginSymmetric(horizontal: 10)
            : SizedBox()
      ],
    ),
  );
}
