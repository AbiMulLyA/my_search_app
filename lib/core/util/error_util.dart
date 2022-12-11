import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/widget/flushbar_widget.dart';
import '../error/failures.dart';

enum ErrorType {
  noInternet,
  noResponse,
  responseInvalid,
  requestFailed,
  systemOffline,
  unKnownError,
  timeoutError,
}

class ErrorUtil {
  //* DioError Handling Exeptions
  static Failure dioCatchError(DioError e) {
    if (e.response != null && e.response!.data is! String) {
      return RemoteFailure(
        code: e.response!.data['code'] as int,
        message: e.response!.data['message'] as String,
        type: ErrorType.requestFailed,
      );
    } else {
      if (e.type == DioErrorType.connectTimeout) {
        return TimeoutFailure(message: e.error.toString());
      } else if (e.type == DioErrorType.response) {
        return RemoteFailure(
          code: 303,
          message: e.error.toString(),
          type: ErrorType.responseInvalid,
        );
      } else {
        return const UnknownFailure();
      }
    }
  }

  //* Error Handling Widget
  static Widget widgetError(BuildContext context, FlutterErrorDetails? error) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Center(
          child: Text(
            "Error Widget.",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  //* Error Handling Network
  static Future<void> networkError({
    required BuildContext context,
    required dynamic errorState,
    bool isLogin = false,
    GestureTapCallback? tapTryAgain,
  }) async {
    debugPrint('ErrorUtil.networkError: ${errorState['code']}');
    if (errorState['code'] == 0 ||
        errorState['code'] == 403 ||
        errorState['code'] == 401 ||
        errorState['type'] == ErrorType.systemOffline) {
      FlushbarWidget.gradation(
        context: context,
        type: FlusbarType.warning,
        message: errorState['message'].toString(),
      ).show(context);
    } else {
      FlushbarWidget.gradation(
        context: context,
        type: errorState['code'] == 404 ||
                errorState['type'] == ErrorType.noResponse
            ? FlusbarType.info
            : FlusbarType.error,
        message: errorState['message'].toString(),
      ).show(context);
    }
  }
}
