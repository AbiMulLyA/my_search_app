import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/util/lang_util.dart';

enum FlusbarType { success, error, warning, info }

//* FlushbarWidget
class FlushbarWidget {
  //* Flushbar.grad
  static Flushbar gradation({
    required BuildContext context,
    required FlusbarType type,
    required String message,
    String? title,
    FlushbarPosition? position,
    Duration duration = const Duration(seconds: 3),
  }) {
    List<Color> colorGrad;
    IconData icon;

    switch (type) {
      case FlusbarType.success:
        title = LangUtil.of(context).trans('global_success');
        colorGrad = Colors.green.shade400 as List<Color>;
        icon = Icons.check_circle;
        break;
      case FlusbarType.error:
        title = LangUtil.of(context).trans('global_error');
        colorGrad = Colors.red.shade400 as List<Color>;
        icon = Icons.check_circle;
        break;
      case FlusbarType.warning:
        title = LangUtil.of(context).trans('global_warning');
        colorGrad = Colors.yellow.shade400 as List<Color>;
        icon = Icons.check_circle;
        break;
      case FlusbarType.info:
        title = LangUtil.of(context).trans('global_info');
        colorGrad = Colors.blue.shade400 as List<Color>;
        icon = Icons.check_circle;
        break;
      default:
        title = LangUtil.of(context).trans('global_info');
        colorGrad = Colors.blue.shade400 as List<Color>;
        icon = Icons.check_circle;
    }

    return Flushbar(
      title: title,
      message: message,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      duration: duration,
      flushbarPosition: position ?? FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.green,
      backgroundGradient: LinearGradient(colors: colorGrad),
      isDismissible: false,
      margin: EdgeInsets.all(8.r),
      borderRadius: BorderRadius.circular(8.r),
    );
  }

  //* simple
  static Flushbar simple({
    required BuildContext context,
    required String message,
    String? title,
    Color? bgColor,
    Color? titleColor,
    Color? messageColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    return Flushbar(
      title: title,
      message: message,
      duration: duration,
      backgroundColor: bgColor ?? Theme.of(context).cardColor,
      titleColor: titleColor ?? Theme.of(context).primaryColor,
      messageColor: messageColor ?? Theme.of(context).primaryColor,
    );
  }

  //* Get a error notification flushbar
  static Flushbar createError(
      {required String message,
      String? title,
      Duration duration = const Duration(seconds: 3)}) {
    return Flushbar(
      title: title,
      message: message,
      icon: Icon(
        Icons.warning,
        size: 28.sp,
        color: Colors.red[300],
      ),
      leftBarIndicatorColor: Colors.red[300],
      duration: duration,
    );
  }

  //* Get a flushbar that can receive a user action through a button.
  static Flushbar createAction(
      {required String message,
      required TextButton button,
      String? title,
      Duration duration = const Duration(seconds: 3)}) {
    return Flushbar(
      title: title,
      message: message,
      duration: duration,
      mainButton: button,
    );
  }

  //* Get a flushbar that shows the progress of a async computation.
  static Flushbar createLoading({
    required String message,
    required LinearProgressIndicator linearProgressIndicator,
    String? title,
    Duration? duration = const Duration(seconds: 3),
    AnimationController? progressIndicatorController,
    Color? progressIndicatorBackgroundColor,
  }) {
    return Flushbar(
      title: title,
      message: message,
      icon: Icon(
        Icons.cloud_upload,
        color: Colors.blue[300],
      ),
      duration: duration,
      showProgressIndicator: true,
      progressIndicatorController: progressIndicatorController,
      progressIndicatorBackgroundColor: progressIndicatorBackgroundColor,
    );
  }

  //* Get a flushbar that shows an user input form.
  static Flushbar createInputFlushbar({
    required Form textForm,
  }) {
    return Flushbar(
      duration: null,
      userInputForm: textForm,
    );
  }
}
