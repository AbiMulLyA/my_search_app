import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.child,
    required this.height,
    this.width,
    this.gradColor,
    this.solidColor,
    this.borderRadius,
    this.borderColor = Colors.transparent,
    this.borderWidth,
    this.paddingLeft = 0.0,
    this.boxShadow = true,
  }) : super(key: key);

  final Widget child;
  final double height;
  final double? width;
  final List<Color>? gradColor;
  final Color? solidColor;
  final double? borderRadius;
  final Color borderColor;
  final double? borderWidth;
  final double paddingLeft;
  final bool boxShadow;

  @override
  Widget build(BuildContext context) {
    //final _theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(left: paddingLeft),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 1.r),
          border: Border.all(
            color: borderColor,
            width: borderWidth ?? 2.w,
          ),
          gradient: gradColor != null
              ? LinearGradient(
                  colors: gradColor!,
                )
              : null,
          color: solidColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF14273E).withOpacity(boxShadow ? .2 : 0.0),
              offset: const Offset(0.0, 5.0),
              blurRadius: 5.0,
            )
          ],
        ),
        child: Material(
          //borderRadius: BorderRadius.circular(borderRadius ?? 1.r),
          color: Colors.transparent,
          child: child,
        ),
      ),
    );
  }
}
