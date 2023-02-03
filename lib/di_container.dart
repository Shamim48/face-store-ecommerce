import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:fakestore/data/datasource/remote/dio/dio_client.dart';
import 'package:fakestore/data/repository/cart_repo.dart';
import 'package:fakestore/data/repository/product_repo.dart';
import 'package:fakestore/data/repository/splash_repo.dart';
import 'package:fakestore/helper/network_info.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'provider/product_provider.dart';
import 'provider/splash_provider.dart';
import 'utill/app_constants.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CartRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  // Provider
  sl.registerFactory(() => ProductProvider(productRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
}
