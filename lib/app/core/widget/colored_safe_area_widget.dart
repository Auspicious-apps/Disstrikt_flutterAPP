/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */


import 'package:disstrikt/app/export.dart';

class ColoredSafeArea extends StatelessWidget {
  final Color? topColor;
  final Color? bottomColor;
  final Color? color;
  final Widget? child;

  const ColoredSafeArea(
      {Key? key,
        this.topColor,
        this.bottomColor,
        this.color,
        @required this.child,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: bottomColor ?? Colors.white, // bottombar color
      child: SafeArea(
        top: false,
        child: ColoredBox(
          color: topColor ?? Colors.white, // statusbar color
          child: SafeArea(
            top: true,
            child: ColoredBox(
              color: color ?? Colors.white, // background color
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}