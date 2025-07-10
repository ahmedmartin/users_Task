
import 'package:clean_architecture_posts_app/user/domain/entities/user.dart';
import 'package:clean_architecture_posts_app/user/domain/repositories/user_repository.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class GetUserByIdUseCase {
  final UserRepository repository;

  GetUserByIdUseCase(this.repository);

  Future<Either<Failure, User>> call({required int id}) async {
    return await repository.getUserById(id: id);
  }
}