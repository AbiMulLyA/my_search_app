import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceWidgetHeight extends StatelessWidget {
  const SpaceWidgetHeight({
    this.child,
    this.height,
  });

  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height ?? 10.r,
        child: child,
      );
}

class SpaceWidgetWidth extends StatelessWidget {
  const SpaceWidgetWidth({
    this.child,
    this.width,
  });

  final Widget? child;
  final double? width;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width ?? 15.r,
        child: child,
      );
}
