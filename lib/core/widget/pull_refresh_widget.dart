import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullRefreshWidget extends StatelessWidget {
  const PullRefreshWidget({
    required this.controller,
    required this.onRefresh,
    required this.child,
    this.primary = false,
    this.distance,
  });

  final RefreshController controller;
  final void Function() onRefresh;
  final Widget child;
  final bool? primary;
  final double? distance;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      primary: primary,
      header: Platform.isIOS
          ? CustomHeader(
              height: distance ?? 60.0,
              builder: (context, mode) {
                return SizedBox(
                  height: 20.h,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      radius: 14.r,
                    ),
                  ),
                );
              },
            )
          : WaterDropMaterialHeader(
              distance: distance ?? 60.0,
              backgroundColor: Colors.grey[50],
              color: Colors.blue,
            ),
      controller: controller,
      onRefresh: () {
        HapticFeedback.heavyImpact();
        onRefresh();
      },
      physics: const BouncingScrollPhysics(),
      child: child,
    );
  }
}
