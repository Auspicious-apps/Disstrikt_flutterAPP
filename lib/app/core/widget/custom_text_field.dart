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

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final double? radius;
  final Color? color;
  final Color? courserColor;
  final Color? fillColor;
  final String? label;
  final validate;
  final hintStyle;
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
    this.inputType,
    this.textController,
    this.hintStyle,
    this.prefix,
    this.courserColor,
    this.validate,
    this.onChange,
    this.decoration,
    this.radius,
    this.focusNode,
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
            style: textStyleBodyMedium().copyWith(
              color: AppColors.smalltextColor,
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
            cursorColor: courserColor ?? AppColors.appColor,
            inputFormatters: inputFormatter ??
                [
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
            style: textStyleBodyMedium()
                .copyWith(color: AppColors.whiteColor, fontFamily: "Kodchasan"),
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
            shadow: BoxShadow(
                color: shadow == true
                    ? AppColors.greyColor.withOpacity(0.5)
                    : AppColors.textfieldBorderColor,
                blurRadius: margin_2,
                spreadRadius: margin_1),
          ),
      focusedErrorBorder: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? margin_10),
                borderSide: BorderSide.none),
            shadow: BoxShadow(
                color: shadow == true
                    ? Colors.grey.withOpacity(0.5)
                    : AppColors.textfieldBorderColor,
                spreadRadius: margin_1),
          ),
      errorBorder: decoration ??
          DecoratedInputBorder(
              child: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? margin_10),
                  borderSide: BorderSide.none),
              shadow: BoxShadow(
                  color: shadow == true
                      ? Colors.grey.withOpacity(0.5)
                      : Colors.red,
                  spreadRadius: margin_1)),
      focusedBorder: decoration ??
          DecoratedInputBorder(
              child: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? margin_10),
                  borderSide: BorderSide(color: borderColor ?? Colors.white)),
              shadow: BoxShadow(
                  color: shadow == true
                      ? AppColors.greyColor.withOpacity(0.5)
                      : AppColors.textfieldBorderColor,
                  spreadRadius: margin_1)),
      enabledBorder: decoration ??
          DecoratedInputBorder(
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? margin_10),
                borderSide: BorderSide(color: borderColor ?? Colors.white)),
            shadow: BoxShadow(
                color: shadow == true
                    ? AppColors.greyColor.withOpacity(0.5)
                    : AppColors.textfieldBorderColor,
                spreadRadius: margin_1),
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
