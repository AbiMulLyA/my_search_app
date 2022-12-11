import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'space_widget.dart';

enum SpinkitType {
  rotatingPlain,
  doubleBounce,
  wave,
  wanderingCubes,
  fadingFour,
  fadingCube,
  pulse,
  chasingDots,
  threeBounce,
  circle,
  cubeGrid,
  fadingCircle,
  rotatingCircle,
  foldingCube,
  pumpingHeart,
  dualRing,
  hourGlass,
  pouringHourGlass,
  ring,
  ripple,
  spinningCircle
}

class LoaderWidgetPlatform extends StatelessWidget {
  const LoaderWidgetPlatform({
    Key? key,
    this.size,
    this.strokeWidth,
    this.valueColor = const AlwaysStoppedAnimation<Color>(Colors.blue),
    this.bgColor = Colors.transparent,
    this.radius,
    this.value,
  }) : super(key: key);

  final double? size;
  final double? strokeWidth;
  final Animation<Color> valueColor;
  final Color bgColor;
  final double? radius;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: size ?? 25.sp,
          height: size ?? 25.sp,
          child: Platform.isIOS
              ? CupertinoActivityIndicator(
                  radius: radius ?? 12.r,
                  animating: true,
                )
              : CircularProgressIndicator(
                  strokeWidth: strokeWidth ?? 3.w,
                  valueColor: valueColor,
                  backgroundColor: bgColor,
                  value: value,
                ),
        ),
      ),
    );
  }
}

class LoaderWidgetShimmer extends StatelessWidget {
  const LoaderWidgetShimmer({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Shimmer.fromColors(
      baseColor: _theme.disabledColor,
      highlightColor: _theme.highlightColor,
      child: child,
    );
  }
}

class LoaderWidgetShimmerSingle extends StatelessWidget {
  const LoaderWidgetShimmerSingle({
    this.width,
    this.height,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return LoaderWidgetShimmer(
      child: Container(
        width: width ?? 50.w,
        height: height ?? 10.h,
        decoration: BoxDecoration(
          color: _theme.hintColor,
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius ?? 12.r),
          ),
        ),
      ),
    );
  }
}

class LoaderWidgetShimmerListImage extends StatelessWidget {
  const LoaderWidgetShimmerListImage({
    this.numRows = 10,
    this.imageHeight,
    this.imageWidth,
    this.marginLeftRight,
  });

  final int numRows;
  final double? imageHeight;
  final double? imageWidth;
  final double? marginLeftRight;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: numRows,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(
                marginLeftRight ?? 15.r,
                10.r,
                marginLeftRight ?? 15.r,
                0.r,
              ),
              child: LoaderWidgetShimmer(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 12.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: _theme.hintColor,
                      ),
                      height: imageHeight ?? 90.h,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                          ),
                        ),
                        child: Container(
                          width: imageWidth ?? 90.w,
                        ),
                      ),
                    ),
                    const SpaceWidgetWidth(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          LoaderWidgetShimmerSingle(
                            height: 15.h,
                            width: 1.sw,
                          ),
                          const SpaceWidgetHeight(),
                          LoaderWidgetShimmerSingle(
                            height: 15.h,
                            width: 0.5.sw,
                          ),
                          const SpaceWidgetHeight(),
                          LoaderWidgetShimmerSingle(
                            height: 15.h,
                            width: 0.3.sw,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LoaderWidgetShimmerListAvatar extends StatelessWidget {
  const LoaderWidgetShimmerListAvatar({
    this.numRows = 10,
    this.paddingVertical,
    this.paddingHorizontal,
    this.paddingBottom,
    this.contentHeight,
  });

  final int numRows;
  final double? paddingVertical;
  final double? paddingHorizontal;
  final double? paddingBottom;
  final double? contentHeight;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    final rows = List<int>.generate(numRows, (i) => i);

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: LoaderWidgetShimmer(
          child: Column(
            children: rows
                .map(
                  (_) => Padding(
                    padding: EdgeInsets.only(bottom: paddingBottom ?? 6.r),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: _theme.hintColor,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.r),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: contentHeight ?? 10.h,
                                decoration: BoxDecoration(
                                  color: _theme.hintColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.r),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.r),
                              ),
                              Container(
                                width: 0.5.sw,
                                height: contentHeight ?? 10.h,
                                decoration: BoxDecoration(
                                  color: _theme.hintColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.r),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.r),
                              ),
                              Container(
                                width: 0.3.sw,
                                height: contentHeight ?? 10.h,
                                decoration: BoxDecoration(
                                  color: _theme.hintColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.r),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
