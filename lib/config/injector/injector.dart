import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api/api.dart';
import 'injector.config.dart';
// import 'injector.config.dart';

final getIt = GetIt.instance;

/* 
@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
*/

final MySearchApi mySearchApi = getIt<MySearchApi>();

//* Initial Getit
@injectableInit
Future<void> configureInjector(String environment) =>
    $initGetIt(getIt, environment: environment);

//* For Thirdparty Plugins
@module
abstract class RegisterModule {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get storage => const FlutterSecureStorage();

  @Named("BaseUrl")
  String get baseUrl => mySearchApi.baseUrl();

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(
        BaseOptions(
          baseUrl: url,
          connectTimeout: MySearchApi.defApiTimeout,
          receiveTimeout: MySearchApi.defApiTimeout,
        ),
      );
}

abstract class Env {
  static const dev = 'dev';
}
