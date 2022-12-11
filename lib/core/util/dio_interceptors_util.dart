import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class DioInterceptorsUtil extends QueuedInterceptorsWrapper {
  DioInterceptorsUtil(this._dio);

  final Dio _dio;

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint(
        "--> onRequest Start ${options.method.toUpperCase()} - ${options.baseUrl}${options.path}");

    debugPrint("Headers: ${options.headers.length}");
    options.headers.forEach((k, v) => debugPrint('$k: $v'));

    debugPrint("queryParameters: ${options.queryParameters.length}");
    options.queryParameters.forEach((k, v) => debugPrint('$k: $v'));

    if (options.data != null) {
      debugPrint("Body: ${options.data}");
      if (options.data is FormData) {
        final form = options.data as FormData;
        debugPrint(
            'Body: ${form.fields.toList()} -- file: ${form.files.toList()}');
      }
    }
    handler.next(options);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    debugPrint(
        "--> onResponse Start ${response.requestOptions.method.toUpperCase()} - ${response.requestOptions.baseUrl}${response.requestOptions.path}");

    debugPrint("Headers:");
    response.headers.forEach((k, v) => debugPrint('$k: $v'));

    debugPrint(
        "<-- onResponse End ${response.requestOptions.method.toUpperCase()}");
    return handler.next(response);
  }
}
