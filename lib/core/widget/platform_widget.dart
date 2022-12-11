import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/lang_util.dart';

class PlatformWidgetSwitch extends StatelessWidget {
  const PlatformWidgetSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool val) onChanged;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoSwitch(
            onChanged: onChanged,
            value: value,
          )
        : Switch(
            onChanged: onChanged,
            value: value,
          );
  }
}

class PlatformWidgetLoader extends StatelessWidget {
  const PlatformWidgetLoader({
    Key? key,
    this.size,
    this.strokeWidth,
    this.valueColor = const AlwaysStoppedAnimation<Color>(Colors.red),
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
                  radius: radius ?? 14.r,
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

class PlatformWidgetModalSheet extends StatelessWidget {
  const PlatformWidgetModalSheet({
    super.key,
    required this.title,
    this.height,
    this.isIos = false,
  });

  final String title;
  final double? height;
  final bool isIos;

  @override
  Widget build(BuildContext context) {
    final _lang = LangUtil.of(context);
    final _theme = Theme.of(context);

    return isIos
        ? CupertinoActionSheet(
            title: Text(title),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () => {},
                child: Text(_lang.trans('global_pick_photo')),
              ),
              CupertinoActionSheetAction(
                onPressed: () => {},
                child: Text(_lang.trans('global_pick_gallery')),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context, _lang.trans('global_cancel'));
              },
              child: Text(_lang.trans('global_cancel')),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: _theme.canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
            height: height ?? 200.h,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(title),
                ),
                Divider(
                  color: Colors.grey[400],
                ),
                GestureDetector(
                  onTap: () => [],
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(_lang.trans('global_pick_photo')),
                  ),
                ),
                Divider(
                  color: Colors.grey[400],
                ),
                GestureDetector(
                  onTap: () => [],
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(_lang.trans('global_pick_gallery')),
                  ),
                ),
                Divider(
                  color: Colors.grey[400],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, _lang.trans('global_cancel'));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(_lang.trans('global_cancel')),
                  ),
                ),
              ],
            ),
          );
  }
}
