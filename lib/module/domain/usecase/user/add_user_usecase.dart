import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../module/domain/repository/user_repository.dart';
import '../../entity/user_entity.dart';
import 'user_param.dart';

@lazySingleton
class AddUserUseCase implements UseCase<UserEntity, UserParam> {
  AddUserUseCase(this.repository);

  final UserRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(UserParam param) async {
    return repository.add(param);
  }
}
