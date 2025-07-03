/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class SquarePercentIndicator extends StatelessWidget {
  final double width;
  final double height;
  final double progress;

  ///square border radius
  final double borderRadius;
  final Color progressColor;
  final Color shadowColor;

  ///thickness of the progress
  final double progressWidth;
  final double shadowWidth;
  final Widget? child;

  ///if true the progress is moving clockwise
  final bool reverse;

  final StartAngle startAngle;

  const SquarePercentIndicator(
      {super.key, 
      this.progress = 0.0,
      this.reverse = false,
      this.borderRadius = 5,
      this.progressColor = Colors.blue,
      this.shadowColor = Colors.grey,
      this.progressWidth = 5,
      this.shadowWidth = 5,
      this.child,
      this.startAngle=StartAngle.topLeft,
      this.width = 150,
      this.height = 150});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: RadialPainter(
            startAngle: startAngle,
            progress: progress,
            color: progressColor,
            shadowColor: shadowColor,
            reverse: reverse,
            strokeCap: StrokeCap.round,
            paintingStyle: PaintingStyle.stroke,
            strokeWidth: progressWidth,
            shadowWidth: shadowWidth,
            borderRadius: borderRadius),
        child: child ?? Container(),
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color shadowColor;
  final StrokeCap strokeCap;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final double shadowWidth;
  final double borderRadius;
  final bool reverse;
  final StartAngle startAngle;

  RadialPainter({
    required this.progress,
    this.color=Colors.blue,
    this.shadowColor=Colors.grey,
    this.strokeWidth=4,
    this.shadowWidth=1,
    this.reverse=false,
    required this.strokeCap,
    required this.paintingStyle,
    this.startAngle = StartAngle.topLeft,
    this.borderRadius = 10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    Paint shadowPaint = Paint()
      ..strokeWidth = shadowWidth
      ..color = shadowColor
      ..style = paintingStyle
      ..strokeCap = strokeCap;

    var path = Path();
    Path dashPath = Path();

    path.moveTo(borderRadius, 0);
    path.lineTo(size.width - borderRadius, 0);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(size.width - borderRadius, borderRadius),
            radius: borderRadius),
        -pi / 2,
        pi / 2,
        false);
    path.lineTo(size.width, size.height - borderRadius);
    path.arcTo(
        Rect.fromCircle(
            center:
                Offset(size.width - borderRadius, size.height - borderRadius),
            radius: borderRadius),
        0,
        pi / 2,
        false);
    path.lineTo(0 + borderRadius, size.height);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(borderRadius, size.height - borderRadius),
            radius: borderRadius),
        pi / 2,
        pi / 2,
        false);
    path.lineTo(0, borderRadius);
    path.arcTo(
        Rect.fromCircle(
            center: Offset(borderRadius, borderRadius), radius: borderRadius),
        pi,
        pi / 2,
        false);

    for (PathMetric pathMetric in path.computeMetrics()) {
      dashPath.addPath(
        pathMetric.extractPath(0, pathMetric.length * progress),
        Offset.zero,
      );
    }

    if (reverse) {
      dashPath = dashPath
          .transform(Matrix4Transform().rotate(pi / 2).m.storage)
          .transform(Matrix4Transform().flipHorizontally().m.storage);
    }

    dashPath = dashPath.transform(
        Matrix4Transform().rotateByCenter(startAngle.value, size).m.storage);

    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum StartAngle { topRight, topLeft, bottomRight, bottomLeft}

extension GetValue on StartAngle {
  double get value => getRotationAngle;

  double get getRotationAngle {
    switch (this) {
      case StartAngle.topLeft:
        return 0;
      case StartAngle.topRight:
        return pi * 0.5;
      case StartAngle.bottomRight:
        return pi * 1.0;
      case StartAngle.bottomLeft:
        return pi * 1.5;
      default:
        return 0;
    }
  }
}

@immutable
class Matrix4Transform {
  final Matrix4 m;

  Matrix4Transform() : m = Matrix4.identity();

  Matrix4Transform.from(Matrix4 m) : m = m.clone();

  const Matrix4Transform._(this.m);

  Matrix4 get matrix4 => m.clone();

  /// Rotates by [angleRadians] radians, clockwise.
  /// If you define an origin it will have that point as the axis of rotation.
  Matrix4Transform rotate(double? angleRadians, { Offset? origin}) {
    if ((angleRadians == null) || (angleRadians == 0.0)) {
      return this;
    } else if ((origin == null) || (origin.dx == 0.0 && origin.dy == 0.0))
      return Matrix4Transform._(m.clone()..rotateZ(angleRadians));
    else
      return Matrix4Transform._(m.clone()
        ..translate(origin.dx, origin.dy)
        ..multiply(Matrix4.rotationZ(angleRadians))
        ..translate(-origin.dx, -origin.dy));
  }

  /// Rotates by [angleDegrees] degrees (0 to 360 one turn), clockwise.
  /// If you define an origin it will have that point as the axis of rotation.
  Matrix4Transform rotateDegrees(double angleDegrees, {Offset? origin}) =>
      rotate(_toRadians(angleDegrees), origin: origin);

  /// Rotates by [angleDegrees] degrees (0 to 360 one turn), clockwise.
  /// The axis of rotation will be the center of the object with the given size.
  Matrix4Transform rotateByCenterDegrees(double angleDegrees, Size size) =>
      rotateByCenter(_toRadians(angleDegrees), size);

  /// Rotates by [angleRadians] radians, clockwise.
  /// The axis of rotation will be the center of the object with the given size.
  Matrix4Transform rotateByCenter(double angleRadians, Size size) => rotate(
    angleRadians,
    origin: Offset(size.width / 2, size.height / 2),
  );

  /// Translates by [x] pixels (horizontal) and [y] pixels (vertical).
  /// Positive goes down/right.
  ///
  Matrix4Transform translate({double? x = 0, double? y = 0}) {
    x ??= 0;
    y ??= 0;

    return (x == 0 && y == 0) //
        ? this
        : Matrix4Transform._(m.clone()..leftTranslate(x, y));
  }

  /// Translates by [x] pixels (horizontal) and [y] pixels (vertical), but in
  /// respect to the original coordinate system, before the translates/scales.
  ///
  /// Example: If you rotate 30 degrees, and then call this method to translate
  /// x:10 it will translate by a distance of 10 pixels in 30 degrees.
  ///
  /// Example: If you resize if by 1.5, and then call this method to translate
  /// x:10 it will translate by 15 pixels.
  ///
  Matrix4Transform translateOriginalCoordinates({
    double? x = 0,
    double? y = 0,
  }) {
    x ??= 0;
    y ??= 0;

    return (x == 0 && y == 0) //
        ? this
        : Matrix4Transform._(m.clone()..translate(x, y));
  }

  /// Scales by [factor], keeping the aspect ratio.
  /// Gets bigger for >1.
  /// Smaller for <1.
  /// Same size for 1 (and passing null is the same as passing 1).
  /// No size for 0.
  /// Passing null is the same as passing 1.
  Matrix4Transform scale(double factor, {Offset? origin}) =>
      scaleBy(x: factor, y: factor, origin: origin);

  /// Scales by a factor of [x] (horizontal) and [y] (vertical).
  /// Gets bigger for >1.
  /// Smaller for <1.
  /// Same size for 1 (and passing null is the same as passing 1).
  /// No size for 0.
  Matrix4Transform scaleBy({double? x = 1, double? y = 1, Offset? origin}) {
    x ??= 1;
    y ??= 1;

    if (x == 1 && y == 1) {
      return this;
    } else if ((origin == null) || (origin.dx == 0.0 && origin.dy == 0.0))
      return Matrix4Transform._(//
          m.clone()..multiply(Matrix4.identity()..scale(x, y)));
    else
      return Matrix4Transform._(//
          m.clone()
            ..translate(origin.dx, origin.dy)
            ..multiply(Matrix4.identity()..scale(x, y))
            ..translate(-origin.dx, -origin.dy));
  }

  /// Scales by [factor] horizontally. Keeps the same vertical scale.
  /// Gets bigger for >1.
  /// Smaller for <1.
  /// Same size for 1 (and passing null is the same as passing 1).
  /// No size for 0.
  Matrix4Transform scaleHorizontally(double factor, {Offset? origin}) =>
      scaleBy(x: factor, origin: origin);

  /// Scales by [factor] vertically. Keeps the same horizontal scale.
  /// Gets bigger for >1.
  /// Smaller for <1.
  /// Same size for 1 (and passing null is the same as passing 1).
  /// No size for 0.
  Matrix4Transform scaleVertically(double factor, {Offset? origin}) =>
      scaleBy(y: factor, origin: origin);

  /// Translates by [x] pixels (horizontal) and [y] pixels (vertical).
  /// Positive goes down/right.
  Matrix4Transform translateOffset(Offset? offset) {
    return (offset == null) //
        ? this
        : Matrix4Transform._(m.clone()..translate(offset.dx, offset.dy));
  }

  /// Translates up by [distance] pixels.
  Matrix4Transform up(double distance) => translate(y: -distance);

  /// Translates down by [distance] pixels.
  Matrix4Transform down(double distance) => translate(y: distance);

  /// Translates right by [distance] pixels.
  Matrix4Transform right(double distance) => translate(x: distance);

  /// Translates up left [distance] pixels.
  Matrix4Transform left(double distance) => translate(x: -distance);

  /// Translates by [distance] pixels to the [direction].
  /// The direction is in radians clockwise from the positive x-axis.
  Matrix4Transform direction(double directionRadians, double distance) =>
      translateOffset(Offset.fromDirection(directionRadians, distance));

  /// Translates by [distance] pixels to the [direction].
  /// The direction is in degrees (0 to 360 one turn) clockwise from the positive x-axis.
  Matrix4Transform directionDegrees(
      double directionDegrees,
      double distance,
      ) =>
      translateOffset(
        Offset.fromDirection(
          _toRadians(directionDegrees),
          distance,
        ),
      );

  /// Translates up and right by [distance] pixels of distance.
  Matrix4Transform upRight(double distance) => //
  direction(-pi / 4, distance);

  /// Translates up and left [distance] pixels.
  Matrix4Transform upLeft(double distance) => //
  direction(-pi * 3 / 4, distance);

  /// Translates down and right by [distance] pixels.
  Matrix4Transform downRight(double distance) => //
  direction(pi / 4, distance);

  /// Translates down and left by [distance] pixels.
  Matrix4Transform downLeft(double distance) => //
  direction(pi * 3 / 4, distance);

  Matrix4Transform flipDiagonally({Offset? origin}) => //
  _flipDegrees(horizontal: 180, vertical: 180, origin: origin);

  Matrix4Transform flipHorizontally({Offset? origin}) => //
  _flipDegrees(horizontal: 180, origin: origin);

  Matrix4Transform flipVertically({Offset? origin}) => //
  _flipDegrees(vertical: 180, origin: origin);

  Matrix4Transform _flip({
    double? horizontal = 0.0,
    double? vertical = 0.0,
    Offset? origin,
  }) {
    if (((horizontal == null) || (horizontal == 0.0)) //
        &&
        ((vertical == null) || (vertical == 0.0))) {
      return this;
    } else if ((origin == null) || (origin.dx == 0.0 && origin.dy == 0.0))
      return Matrix4Transform._(m.clone()
        ..rotateY(horizontal!)
        ..rotateX(vertical!));
    else
      return Matrix4Transform._(m.clone()
        ..translate(origin.dx, origin.dy)
        ..multiply(Matrix4.rotationY(horizontal!))
        ..multiply(Matrix4.rotationX(vertical!))
        ..translate(-origin.dx, -origin.dy));
  }

  /// Flips (with perspective) horizontally and vertically by [distance] pixels.
  Matrix4Transform _flipDegrees({
    double horizontal = 0.0,
    double vertical = 0.0,
    Offset? origin,
  }) {
    return _flip(
      horizontal: _toRadians(horizontal),
      vertical: _toRadians(vertical),
      origin: origin,
    );
  }

  double _toRadians(double angleDegrees) => angleDegrees * pi / 180;
}

class Matrix4TransformTween extends Tween<Matrix4Transform> {
  Matrix4TransformTween({required Matrix4Transform begin,required Matrix4Transform end})
      : super(begin: begin, end: end);

  @override
  Matrix4Transform lerp(double t) {
    return Matrix4Transform.from(
      Matrix4Tween(begin: begin!.matrix4, end: end!.matrix4).lerp(t),
    );
  }
}
