import 'package:flucommerce/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width, this.radius})
      : super(key: key);
  final double? height, width, radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kcCartItemBackgroundColor,
      highlightColor: kcSecondaryColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 10),
          color: kcCartItemBackgroundColor,
        ),
      ),
    );
  }
}
