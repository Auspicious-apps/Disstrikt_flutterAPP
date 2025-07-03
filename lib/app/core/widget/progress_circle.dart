import 'package:flutter/material.dart';
import 'package:disstrikt/app/core/values/app_colors.dart';

class ProgressCircle extends StatelessWidget {
  const ProgressCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: AppColors.appColor,
      strokeWidth: 2,
      valueColor:   AlwaysStoppedAnimation<Color>(
        Colors.white,
      ),
    );
  }
}