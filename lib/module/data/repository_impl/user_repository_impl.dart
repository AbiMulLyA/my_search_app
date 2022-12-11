import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/util/connection_util.dart';
import '../../../core/util/error_util.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../../domain/usecase/user/user_param.dart';
import '../datasource/remote/user/user_remote_datasource.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final ConnectionUtil connectionUtil;
  Dio dio;
  UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({
    required this.connectionUtil,
    required this.dio,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> list(UserParam param) async {
    if (await connectionUtil.checkConnection()) {
      debugPrint('$runtimeType.list: 1');
      try {
        dio.options.headers.addAll({"requiresToken": true});

        final httpResponse = await remoteDataSource.list(param);
        debugPrint("$runtimeType :$httpResponse");

        if (httpResponse.response.statusCode == HttpStatus.ok) {
          return Right(httpResponse.data);
        }

        debugPrint('$runtimeType.list: 2');
        return Left(
          RemoteFailure(
            code: httpResponse.response.data['code'] as int,
            message: httpResponse.response.data['message'] as String,
            type: ErrorType.responseInvalid,
          ),
        );
      } on DioError catch (e) {
        debugPrint(
            '$runtimeType.list: 3 - DioError ${e.message} ${e.type} ${e.error}');

        return left(ErrorUtil.dioCatchError(e));
      }
    } else {
      debugPrint('$runtimeType.list: 4 - NoInternetFailure');
      return const Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> add(UserParam param) async {
    if (await connectionUtil.checkConnection()) {
      debugPrint('$runtimeType.add: 1');
      try {
        dio.options.headers.addAll({"requiresToken": true});

        final httpResponse = await remoteDataSource.add(param);
        debugPrint("$runtimeType :$httpResponse");

        if (httpResponse.response.statusCode == HttpStatus.created) {
          return Right(httpResponse.data);
        }

        debugPrint('$runtimeType.add: 2');
        return Left(
          RemoteFailure(
            code: httpResponse.response.data['code'] as int,
            message: httpResponse.response.data['message'] as String,
            type: ErrorType.responseInvalid,
          ),
        );
      } on DioError catch (e) {
        debugPrint(
            '$runtimeType.add: 3 - DioError ${e.message} ${e.type} ${e.error}');

        return left(ErrorUtil.dioCatchError(e));
      }
    } else {
      debugPrint('$runtimeType.addt: 4 - NoInternetFailure');
      return const Left(NoInternetFailure());
    }
  }
}
