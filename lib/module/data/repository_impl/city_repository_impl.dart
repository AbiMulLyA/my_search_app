import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../../../core/util/connection_util.dart';
import '../../../core/util/error_util.dart';
import '../../domain/entity/city_entity.dart';
import '../../domain/repository/city_repository.dart';
import '../datasource/remote/city/city_remote_datasource.dart';

@LazySingleton(as: CityRepository)
class CityRepositoryImpl implements CityRepository {
  final ConnectionUtil connectionUtil;
  Dio dio;
  CityRemoteDataSource remoteDataSource;

  CityRepositoryImpl({
    required this.connectionUtil,
    required this.dio,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<CityEntity>>> list(NoParam param) async {
    if (await connectionUtil.checkConnection()) {
      debugPrint('$runtimeType: 1');
      try {
        dio.options.headers.addAll({"requiresToken": true});

        final httpResponse = await remoteDataSource.city();

        if (httpResponse.response.statusCode == HttpStatus.ok) {
          return Right(httpResponse.data);
        }

        debugPrint('$runtimeType: 2');
        return Left(
          RemoteFailure(
            code: httpResponse.response.data['code'] as int,
            message: httpResponse.response.data['message'] as String,
            type: ErrorType.responseInvalid,
          ),
        );
      } on DioError catch (e) {
        debugPrint(
            '$runtimeType: 3 - DioError ${e.message} ${e.type} ${e.error}');

        return left(ErrorUtil.dioCatchError(e));
      }
    } else {
      debugPrint('$runtimeType: 4 - NoInternetFailure');
      return const Left(NoInternetFailure());
    }
  }
}
