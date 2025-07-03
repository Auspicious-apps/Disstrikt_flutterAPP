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

class MaterialButtonWidget extends StatelessWidget {
  final String? buttonText;
  // ignore: prefer_typing_uninitialized_variables
  final TextStyle? buttonTextStyle;
  final Color? buttonBgColor;
  final Color? textColor;
  final double? buttonRadius;
  final double? minWidth;
  final double? minHeight;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Function()? onPressed;
  final double? elevation;
  final Color? borderColor;
  final double? borderWidth;
  final Widget? widget;
  final Widget? iconWidget;
  final bool isOutlined;
  final bool isloading;
  final int? isContact;

  const MaterialButtonWidget({
    Key? key,
    this.buttonText = "",
    this.buttonBgColor,
    this.buttonTextStyle,
    this.textColor,
    this.buttonRadius,
    required this.onPressed,
    this.elevation,
    this.borderColor,
    this.borderWidth,
    this.minWidth,
    this.minHeight,
    this.verticalPadding,
    this.horizontalPadding,
    this.widget,
    this.isloading = false,
    this.iconWidget,
    this.isContact,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: minHeight ?? height_48,
        splashColor: Colors.transparent,
        minWidth: minWidth ?? Get.width,
        color: isOutlined
            ? buttonBgColor ?? Colors.white
            : (buttonBgColor ?? AppColors.appColor),
        elevation: elevation ?? radius_0,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: isOutlined
                    ? (borderColor ?? AppColors.appColor)
                    : Colors.transparent,
                width: isOutlined ? width_1 : width_0),
            borderRadius: BorderRadius.circular(buttonRadius ?? margin_8)),
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? margin_8,
            horizontal: horizontalPadding ?? margin_20),
        child: widget ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isloading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.black))
                    : TextView(
                        text: buttonText!,
                        textStyle: buttonTextStyle ??
                            textStyleTitleMedium().copyWith(
                                fontFamily: "TOMMYSOFT",
                                color: isOutlined
                                    ? textColor ?? (Colors.black)
                                    : (textColor ?? Colors.black))),
                isloading ? SizedBox() : iconWidget ?? const SizedBox(),
              ],
            ));
  }
}
