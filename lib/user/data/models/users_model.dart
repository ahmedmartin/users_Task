
import 'package:clean_architecture_posts_app/user/data/models/user_model.dart';
import 'package:clean_architecture_posts_app/user/domain/entities/users.dart';

class UsersModel extends Users{
    UsersModel({
        required this.page,
        required this.perPage,
        required this.total,
        required this.totalPages,
        required this.data,
    }) : super(page: page, perPage: perPage, total: total, totalPages: totalPages, data: data);

    final int? page;
    final int? perPage;
    final int? total;
    final int? totalPages;
    final List<UserModel> data;

    factory UsersModel.fromJson(Map<String, dynamic> json){ 
        return UsersModel(
            page: json["page"],
            perPage: json["per_page"],
            total: json["total"],
            totalPages: json["total_pages"],
            data: json["data"] == null ? [] : List<UserModel>.from(json["data"]!.map((x) => UserModel.fromJson(x))),
            
        );
    }

}




