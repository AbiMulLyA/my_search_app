import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../module/domain/repository/city_repository.dart';
import '../../entity/city_entity.dart';

@lazySingleton
class CityUseCase implements UseCase<List<CityEntity>, NoParam> {
  CityUseCase(this.repository);

  final CityRepository repository;

  @override
  Future<Either<Failure, List<CityEntity>>> call(NoParam param) async {
    return repository.list(param);
  }
}
