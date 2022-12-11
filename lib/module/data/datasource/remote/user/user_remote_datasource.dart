// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../domain/usecase/user/user_param.dart';
import '../../../model/user/user_model.dart';

part 'user_remote_datasource.g.dart';

@injectable
@RestApi()
abstract class UserRemoteDataSource {
  @factoryMethod
  factory UserRemoteDataSource(Dio dio, {@Named('BaseUrl') String baseUrl}) =
      _UserRemoteDataSource;

  @GET('/user')
  Future<HttpResponse<List<UserModel>>> list(@Queries() UserParam param);
  @POST('/user')
  Future<HttpResponse<UserModel>> add(@Body() UserParam param);
}
