import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../entity/user_entity.dart';
import '../usecase/user/user_param.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> list(UserParam param);
  Future<Either<Failure, UserEntity>> add(UserParam param);
}
