import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    this.leading,
    this.trailing,
    required this.title,
    this.subTitle,
    this.subTitle2,
    this.tap,
    this.margin,
    this.paddingLeft,
    this.paddingTop,
    this.paddingBottom,
    this.paddingRight,
    this.isDivider = false,
    this.deviderSize,
    this.color,
  });

  final Widget? leading;
  final Widget? trailing;
  final String title;
  final String? subTitle;
  final String? subTitle2;
  final GestureTapCallback? tap;
  final double? margin;
  final double? paddingLeft;
  final double? paddingTop;
  final double? paddingBottom;
  final double? paddingRight;
  final bool isDivider;
  final double? deviderSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(
        left: margin ?? 0.r,
        top: margin ?? 0.r,
        right: margin ?? 0.r,
      ),
      child: Column(
        children: [
          Material(
            color: color ?? _theme.canvasColor,
            child: InkWell(
              onTap: tap,
              child: Container(
                padding: EdgeInsets.only(
                  left: paddingLeft ?? 15.r,
                  top: paddingTop ?? 15.r,
                  bottom: paddingBottom ?? 0.r,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (leading != null) ...[
                      Padding(
                        padding: EdgeInsets.only(right: 20.r),
                        child: leading,
                      ),
                    ],
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      title,
                                      style: _theme.textTheme.bodyText1!
                                          .copyWith(height: 1.5),
                                    ),
                                    if (subTitle != null) ...[
                                      Text(
                                        subTitle!,
                                        style: _theme.textTheme.subtitle2!
                                            .copyWith(height: 1.5),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ] else ...[
                                      SizedBox(height: 15.h),
                                    ],
                                    if (subTitle2 != null) ...[
                                      Text(
                                        subTitle2!,
                                        style: _theme.textTheme.subtitle2!
                                            .copyWith(height: 1.5),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ]
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10.r),
                                child: trailing ??
                                    const Icon(
                                      Icons.keyboard_arrow_right,
                                    ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.r),
                            child: isDivider
                                ? Divider(
                                    height: 1.h,
                                    thickness: 0.1.r,
                                    color: _theme.primaryColor,
                                  )
                                : SizedBox(
                                    height: 0.h,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: deviderSize ?? 10.r,
            ),
          ),
        ],
      ),
    );
  }
}
