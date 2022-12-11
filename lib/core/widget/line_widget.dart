import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LineWidgetHor extends StatelessWidget {
  const LineWidgetHor({
    this.width,
    this.height,
    this.color,
  });

  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Colors.grey[300],
            borderRadius: BorderRadius.all(
              Radius.circular(16.r),
            ),
          ),
          width: width ?? 50.w,
          height: height ?? 3.h,
        ),
      );
}

class LineWidgetHorDash extends StatelessWidget {
  const LineWidgetHorDash({
    this.width,
    this.height,
    this.color,
  });

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = width ?? 3.w;
        final dashHeight = height ?? 1.h;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: Container(
                  decoration: BoxDecoration(
                    color: color ?? Theme.of(context).hintColor,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
