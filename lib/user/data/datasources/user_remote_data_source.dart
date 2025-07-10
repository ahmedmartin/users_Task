import 'package:clean_architecture_posts_app/user/data/models/user_model.dart';
import 'package:clean_architecture_posts_app/user/data/models/users_model.dart';
import 'package:clean_architecture_posts_app/core/strings/api_urls.dart';
import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';

abstract class UserRemoteDataSource {
  Future<UsersModel> getAllUsers({required int page});
  Future<UserModel> getUserById({required int id});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio client;

  UserRemoteDataSourceImpl({required this.client});
  @override
  Future<UsersModel> getAllUsers(
      {required int page}) async {
    final response = await client.get(AllUsersURL(page));
    try{
    if (response.statusCode == 200) {
      return UsersModel.fromJson(response.data);
    } else {
      throw ServerException();
    }}catch(e){
      throw ServerException();
    }
  }


  @override
  Future<UserModel> getUserById({required int id}) async {
    try{
      final response = await client.get(UserByIdURL(id));
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
    }catch(e){
      throw ServerException();
    }
  }
}
