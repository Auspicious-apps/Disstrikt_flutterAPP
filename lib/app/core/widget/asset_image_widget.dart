import 'package:flutter/material.dart';

class AssetImageWidget extends StatelessWidget {
  final String imagePath;
  final double? imageHeight;
  final double? imageWidth;
  final BoxFit? fit;
  final Color? color;

  const AssetImageWidget(
    this.imagePath, {
    Key? key,
    this.imageHeight,
    this.imageWidth,
    this.fit,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: imageHeight,
      width: imageWidth,
      fit: fit ?? BoxFit.contain,
      color: color,
    );
  }
}