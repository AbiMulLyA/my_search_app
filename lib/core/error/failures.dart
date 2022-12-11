import 'package:equatable/equatable.dart';

import '../util/error_util.dart';
import '../util/global_util.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.code,
    required this.message,
    required this.type,
  });

  final int code;
  final String message;
  final dynamic type;

  @override
  List<Object> get props => [code, message];

  @override
  bool get stringify => true;
}

//* RemoteFailure
class RemoteFailure extends Failure {
  const RemoteFailure({
    required int code,
    required String message,
    required dynamic type,
  }) : super(
          code: code,
          message: message,
          type: type,
        );
}

//* NoInternetFailure
class NoInternetFailure extends Failure {
  const NoInternetFailure()
      : super(
          code: 0,
          message: kNoInternet,
          type: ErrorType.noInternet,
        );
}

//* TimeoutFailure
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    String? message,
  }) : super(
          code: 0,
          message: message ?? kTimeoutError,
          type: ErrorType.timeoutError,
        );
}

//* UnknownFailure
class UnknownFailure extends Failure {
  const UnknownFailure()
      : super(
          code: 0,
          message: kUnknownError,
          type: ErrorType.unKnownError,
        );
}

//* LocalFailure
class LocalFailure extends Failure {
  const LocalFailure({
    dynamic type,
  }) : super(
          code: 0,
          message: kLocalError,
          type: type,
        );
}
