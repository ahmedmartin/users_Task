
import 'package:clean_architecture_posts_app/user/domain/entities/user.dart';
import 'package:clean_architecture_posts_app/user/domain/entities/users.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, Users>> getAllUsers({required int page});
  
  Future<Either<Failure, User>> getUserById({required int id});

}
