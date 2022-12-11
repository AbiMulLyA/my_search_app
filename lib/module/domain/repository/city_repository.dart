import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../entity/city_entity.dart';

abstract class CityRepository {
  Future<Either<Failure, List<CityEntity>>> list(NoParam param);
}
