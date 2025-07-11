import 'package:clean_architecture_posts_app/user/data/datasources/user_remote_data_source.dart';
import 'package:clean_architecture_posts_app/user/data/repositories/user_repository_impl.dart';
import 'package:clean_architecture_posts_app/user/domain/repositories/user_repository.dart';
import 'package:clean_architecture_posts_app/user/domain/usecases/get_all_user_use_case.dart';
import 'package:clean_architecture_posts_app/user/domain/usecases/get_user_by_id_use_case.dart';
import 'package:clean_architecture_posts_app/user/presentation/bloc/user/user_bloc.dart';
import 'package:clean_architecture_posts_app/user/presentation/bloc/users/users_bloc.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => UserBloc(getUserUseCase: sl()));
  sl.registerFactory(() => UsersBloc(getAllUsersUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllUsersUseCase(sl()));
  sl.registerLazySingleton(() => GetUserByIdUseCase(sl()));

// Repository

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      remoteDataSource: sl(),networkInfo: sl()));


// Datasources

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
