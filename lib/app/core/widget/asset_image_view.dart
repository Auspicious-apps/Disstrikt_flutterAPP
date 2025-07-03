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

class AssetImageView extends StatelessWidget {
  final String fileName;
  final double? height;
  final double? width;
  final double? raduisAll;
  final double? topLeftRaduis;
  final double? topRightRaduis;
  final double? bottomLeftRaduis;
  final double? bottomRightRaduis;
  final Color? color;
  final double? scale;
  final BoxFit? fit;

  const AssetImageView({
    Key? key,
    required this.fileName,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.raduisAll,
    this.topLeftRaduis,
    this.topRightRaduis,
    this.bottomLeftRaduis,
    this.bottomRightRaduis,
    this.scale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: raduisAll == null
          ? BorderRadius.only(
              topLeft: Radius.circular(topLeftRaduis ?? 0.0),
              bottomLeft: Radius.circular(bottomLeftRaduis ?? 0.0),
              bottomRight: Radius.circular(bottomRightRaduis ?? 0.0),
              topRight: Radius.circular(topRightRaduis ?? 0.0),
            )
          : BorderRadius.all(Radius.circular(raduisAll!)),
      child: Image.asset(
        fileName,
        height: height,
        width: width,
        fit: fit,
      ),
    );
  }
}
