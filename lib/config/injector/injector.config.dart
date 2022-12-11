// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i10;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../../core/bloc/auth/auth_bloc.dart' as _i3;
import '../../core/bloc/lang/lang_bloc.dart' as _i6;
import '../../core/util/connection_util.dart' as _i4;
import '../../core/util/dio_interceptors_util.dart' as _i11;
import '../../module/data/datasource/remote/city/city_remote_datasource.dart'
    as _i16;
import '../../module/data/datasource/remote/user/user_remote_datasource.dart'
    as _i12;
import '../../module/data/repository_impl/city_repository_impl.dart' as _i18;
import '../../module/data/repository_impl/user_repository_impl.dart' as _i14;
import '../../module/domain/repository/city_repository.dart' as _i17;
import '../../module/domain/repository/user_repository.dart' as _i13;
import '../../module/domain/usecase/city/city_usecase.dart' as _i19;
import '../../module/domain/usecase/user/add_user_usecase.dart' as _i15;
import '../../module/domain/usecase/user/get_user_usecase.dart' as _i20;
import '../../module/presentation/bloc/user/user_bloc.dart' as _i21;
import '../../module/presentation/cubit/city/city_cubit.dart' as _i22;
import '../api/api.dart' as _i7;
import '../api/dev_api.dart' as _i8;
import 'injector.dart' as _i23;

const String _dev = 'dev';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.AuthBloc>(() => _i3.AuthBloc());
  gh.lazySingleton<_i4.ConnectionUtil>(() => _i4.ConnectionUtil());
  gh.lazySingleton<_i5.FlutterSecureStorage>(() => registerModule.storage);
  gh.lazySingleton<_i6.LangBloc>(() => _i6.LangBloc());
  gh.factory<_i7.MySearchApi>(
    () => _i8.DevMySearchApi(),
    registerFor: {_dev},
  );
  await gh.lazySingletonAsync<_i9.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<String>(
    () => registerModule.baseUrl,
    instanceName: 'BaseUrl',
  );
  gh.lazySingleton<_i10.Dio>(
      () => registerModule.dio(get<String>(instanceName: 'BaseUrl')));
  gh.singleton<_i11.DioInterceptorsUtil>(
      _i11.DioInterceptorsUtil(get<_i10.Dio>()));
  gh.factory<_i12.UserRemoteDataSource>(() => _i12.UserRemoteDataSource(
        get<_i10.Dio>(),
        baseUrl: get<String>(instanceName: 'BaseUrl'),
      ));
  gh.lazySingleton<_i13.UserRepository>(() => _i14.UserRepositoryImpl(
        connectionUtil: get<_i4.ConnectionUtil>(),
        dio: get<_i10.Dio>(),
        remoteDataSource: get<_i12.UserRemoteDataSource>(),
      ));
  gh.lazySingleton<_i15.AddUserUseCase>(
      () => _i15.AddUserUseCase(get<_i13.UserRepository>()));
  gh.factory<_i16.CityRemoteDataSource>(() => _i16.CityRemoteDataSource(
        get<_i10.Dio>(),
        baseUrl: get<String>(instanceName: 'BaseUrl'),
      ));
  gh.lazySingleton<_i17.CityRepository>(() => _i18.CityRepositoryImpl(
        connectionUtil: get<_i4.ConnectionUtil>(),
        dio: get<_i10.Dio>(),
        remoteDataSource: get<_i16.CityRemoteDataSource>(),
      ));
  gh.lazySingleton<_i19.CityUseCase>(
      () => _i19.CityUseCase(get<_i17.CityRepository>()));
  gh.lazySingleton<_i20.GetUserUseCase>(
      () => _i20.GetUserUseCase(get<_i13.UserRepository>()));
  gh.factory<_i21.UserBloc>(() => _i21.UserBloc(
        get<_i20.GetUserUseCase>(),
        get<_i15.AddUserUseCase>(),
      ));
  gh.factory<_i22.CityCubit>(() => _i22.CityCubit(get<_i19.CityUseCase>()));
  return get;
}

class _$RegisterModule extends _i23.RegisterModule {}
