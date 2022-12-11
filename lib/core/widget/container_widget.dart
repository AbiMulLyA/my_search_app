import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerWidgetShadow extends StatelessWidget {
  const ContainerWidgetShadow({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).secondaryHeaderColor,
              spreadRadius: 2.r,
              blurRadius: 10.r,
              offset: Offset(0, 8.r),
            ),
          ],
        ),
        child: child,
      );
}

class ContainerWidgetDefaultMargin extends StatelessWidget {
  const ContainerWidgetDefaultMargin({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(
          left: 15.r,
          top: 10.r,
          right: 15.r,
          bottom: 10.r,
        ),
        child: child,
      );
}

class ContainerWidgetBox extends StatelessWidget {
  const ContainerWidgetBox({
    this.child,
    this.color,
    this.height,
    this.width,
    this.padding,
    this.boxRadius,
    this.boxBorder,
    this.borderRadius,
  });

  final Widget? child;
  final Color? color;
  final double? height;
  final double? width;
  final double? padding;
  final double? boxRadius;
  final BoxBorder? boxBorder;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        //padding: EdgeInsets.all(15.r),
        padding: EdgeInsets.all(padding ?? 1.r),
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.secondary,
          border: boxBorder,
          borderRadius: borderRadius ??
              BorderRadius.all(
                Radius.circular(
                  boxRadius ?? 12.r,
                ),
              ),
        ),
        child: child ?? const SizedBox(),
      );
}

class ContainerWidgetSlideBackgroud extends StatelessWidget {
  const ContainerWidgetSlideBackgroud({
    this.color,
    this.iconData,
    required this.title,
    this.textAlign = TextAlign.right,
  });

  final Color? color;
  final IconData? iconData;
  final String title;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) => ContainerWidgetBox(
        color: color ?? Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (iconData != null) ...[
                  Icon(
                    iconData,
                    color: Colors.white,
                  ),
                ],
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.white),
                  textAlign: textAlign,
                ),
              ],
            ),
          ),
        ),
      );
}
