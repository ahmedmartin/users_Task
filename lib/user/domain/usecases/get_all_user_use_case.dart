

import 'package:clean_architecture_posts_app/user/domain/entities/users.dart';
import 'package:clean_architecture_posts_app/user/domain/repositories/user_repository.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class GetAllUsersUseCase {
  final UserRepository repository;

  GetAllUsersUseCase(this.repository);

  Future<Either<Failure, Users>> call({required int page}) async {
    return await repository.getAllUsers(page: page);
  }
}