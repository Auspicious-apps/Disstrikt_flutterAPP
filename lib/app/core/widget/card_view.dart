

/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import '../../export.dart';

class CardViewScreen extends StatelessWidget {
  final double? radius;
  final Color? borderColor;
  final Color? color;
  final Color? shadowColor;
  final Widget? widget;

  const CardViewScreen(
      {super.key, this.radius,
      this.borderColor,
      this.color,
      this.shadowColor,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: shadowColor ?? Colors.transparent,
              blurRadius: margin_3,
              spreadRadius: margin_3)
        ],
        borderRadius: BorderRadius.circular(radius!),
        border: Border.all(color: borderColor!),
        color: color,
      ),
      child: widget,
    );
  }
}
