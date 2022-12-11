import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@factoryMethod
abstract class MySearchApi {
  static const String appName = "My Search App";
  static const int defApiTimeout = 20000; //in milisecond
  static const int defFetchLimit = 10;
  static const String devHost = "627e360ab75a25d3f3b37d5a.mockapi.io";

  static BaseOptions dioBaseOptions = BaseOptions(
    connectTimeout: defApiTimeout,
    receiveTimeout: defApiTimeout,
  );

  String apiKeyOneSignal();
  String baseUrl();
  String environment();
}
