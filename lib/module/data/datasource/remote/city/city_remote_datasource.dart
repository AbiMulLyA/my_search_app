// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../model/city/city_model.dart';

part 'city_remote_datasource.g.dart';

@injectable
@RestApi()
abstract class CityRemoteDataSource {
  @factoryMethod
  factory CityRemoteDataSource(Dio dio, {@Named('BaseUrl') String baseUrl}) =
      _CityRemoteDataSource;

  @GET('/city')
  Future<HttpResponse<List<CityModel>>> city();
}
