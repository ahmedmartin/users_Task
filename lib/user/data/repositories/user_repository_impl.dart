import 'package:clean_architecture_posts_app/user/data/datasources/user_remote_data_source.dart';
import 'package:clean_architecture_posts_app/user/domain/entities/user.dart';
import 'package:clean_architecture_posts_app/user/domain/entities/users.dart';
import 'package:clean_architecture_posts_app/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });



  @override
  Future<Either<Failure, Users>> getAllUsers(
      {required int page}) async {
    try {
      final users =
          await remoteDataSource.getAllUsers(page: page);
      return Right(users);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getUserById({required int id}) async {
    try {
      final product = await remoteDataSource.getUserById(id: id);
      return Right(product);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
