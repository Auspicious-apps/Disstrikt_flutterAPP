/*
<!--

  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains

  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:disstrikt/app/export.dart';

class CapitalizeFirstLetterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    // Capitalize the first letter and keep the rest of the string
    String newText =
        newValue.text[0].toUpperCase() + newValue.text.substring(1);
    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final double? radius;
  final Color? color;
  final Color? courserColor;
  final Color? fillColor;
  final Color? textColors;
  final Color? lableColor;
  final String? label;
  final validate;
  final hintStyle;
  final textlableStyle;
  final EdgeInsets? contentPadding;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputAction? inputAction;
  final bool? hideBorder;
  final bool? isFilled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxline;
  final decoration;
  final int? minLine;
  final int? maxLength;
  final bool readOnly;
  final bool? shadow;
  final bool? obscureText;
  final bool? isOutined;
  final Function(String value)? onChange;
  final inputFormatter;
  final errorColor;
  final prefix;
  final borderColor;

  const TextFieldWidget({
    super.key,
    this.hint,
    this.textColors,
    this.inputType,
    this.lableColor,
    this.textController,
    this.hintStyle,
    this.prefix,
    this.courserColor,
    this.validate,
    this.onChange,
    this.decoration,
    this.radius,
    this.focusNode,
    this.textlableStyle,
    this.readOnly = false,
    this.shadow,
    this.onFieldSubmitted,
    this.inputAction,
    this.contentPadding,
    this.isOutined = false,
    this.maxline = 1,
    this.minLine = 1,
    this.maxLength,
    this.color,
    this.hideBorder = true,
    this.suffixIcon,
    this.prefixIcon,
    this.label,
    this.obscureText,
    this.onTap,
    this.isFilled,
    this.fillColor,
    this.inputFormatter,
    this.errorColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            maxLines: 1,
            label!,
            style: textlableStyle ??
                textStyleBodyMedium().copyWith(
                  color: lableColor ?? AppColors.smalltextColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Kodchasan",
                ),
          ),
        if (label != null) SizedBox(height: margin_10),
        TextFormField(
            readOnly: readOnly,
            onTap: onTap,
            obscureText: obscureText ?? false,
            controller: textController,
            focusNode: focusNode,
            keyboardType: inputType,
            maxLength: maxLength,
            onChanged: onChange,
            // cursorColor: courserColor ?? AppColors.appColor,
            inputFormatters: [
              CapitalizeFirstLetterFormatter(),
              if (inputFormatter != null) ...inputFormatter,
              FilteringTextInputFormatter(
                  RegExp(
                      '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                  allow: false),
            ],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLines: maxline,
            minLines: minLine,
            textInputAction: inputAction,
            onFieldSubmitted: onFieldSubmitted,
            validator: validate,
            style: textStyleBodyMedium().copyWith(
                color: textColors ?? AppColors.whiteColor,
                fontFamily: "Kodchasan"),
            decoration: inputDecoration()),
      ],
    );
  }

  inputDecoration() => InputDecoration(
      counterText: "",
      errorMaxLines: 3,
      isDense: false,
      errorStyle: TextStyle(
          fontSize: font_10,
          fontWeight: FontWeight.w500,
          color: errorColor ?? Colors.red),
      filled: isFilled ?? true,
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(
            horizontal: margin_15,
            vertical: margin_12,
          ),
      prefixIcon: prefixIcon,
      prefix: prefix,
      suffixIcon: isOutined == true ? null : suffixIcon,
      hintText: hint,
      hintStyle: hintStyle ??
          textStyleBodyMedium().copyWith(color: Colors.white, height: 2.0),
      fillColor: fillColor ?? AppColors.whiteColor,
      border: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? margin_10),
                borderSide: BorderSide(color: borderColor ?? Colors.white)),
            shadow: BoxShadow(blurRadius: margin_0, spreadRadius: margin_0),
          ),
      focusedErrorBorder: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? margin_10),
                borderSide: BorderSide.none),
            shadow: BoxShadow(blurRadius: margin_0, spreadRadius: margin_0),
          ),
      errorBorder: decoration ??
          DecoratedInputBorder(
              child: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? margin_10),
                  borderSide: BorderSide(color: Colors.red ?? Colors.white)),
              shadow: BoxShadow(blurRadius: margin_0, spreadRadius: margin_0)),
      focusedBorder: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? margin_10),
                borderSide: BorderSide(color: borderColor ?? Colors.white)),
            shadow: BoxShadow(blurRadius: margin_0, spreadRadius: margin_0),
          ),
      enabledBorder: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? margin_10),
                borderSide: BorderSide(color: borderColor ?? Colors.white)),
            shadow: BoxShadow(blurRadius: margin_0, spreadRadius: margin_0),
          ));
}

class DecoratedInputBorder extends InputBorder {
  DecoratedInputBorder({
    required this.child,
    required this.shadow,
  }) : super(borderSide: child.borderSide);

  final InputBorder child;

  final BoxShadow? shadow;

  @override
  bool get isOutline => child.isOutline;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  @override
  InputBorder copyWith(
      {BorderSide? borderSide,
      InputBorder? child,
      BoxShadow? shadow,
      bool? isOutline}) {
    return DecoratedInputBorder(
      child: (child ?? this.child).copyWith(borderSide: borderSide),
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ShapeBorder scale(double t) {
    final scalledChild = child.scale(t);

    return DecoratedInputBorder(
      child: scalledChild is InputBorder ? scalledChild : child,
      shadow: BoxShadow.lerp(null, shadow, t),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double gapExtent = 0.0,
      double gapPercentage = 0.0,
      TextDirection? textDirection}) {
    final clipPath = Path()
      ..addRect(const Rect.fromLTWH(-5000, -5000, 10000, 10000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    final Paint paint = shadow!.toPaint();
    final Rect bounds =
        rect.shift(shadow!.offset).inflate(shadow!.spreadRadius);

    canvas.drawPath(getOuterPath(bounds), paint);

    child.paint(canvas, rect,
        gapStart: gapStart,
        gapExtent: gapExtent,
        gapPercentage: gapPercentage,
        textDirection: textDirection);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is DecoratedInputBorder &&
        other.borderSide == borderSide &&
        other.child == child &&
        other.shadow == shadow;
  }

  @override
  int get hashCode => Object.hash(borderSide, child, shadow);
}
