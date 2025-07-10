import 'package:clean_architecture_posts_app/user/domain/entities/user.dart';
import 'package:equatable/equatable.dart';


class Users extends Equatable{
    const Users({
        required this.page,
        required this.perPage,
        required this.total,
        required this.totalPages,
        required this.data,
    });

    final int? page;
    final int? perPage;
    final int? total;
    final int? totalPages;
    final List<User> data;

    factory Users.fromJson(Map<String, dynamic> json){ 
        return Users(
            page: json["page"],
            perPage: json["per_page"],
            total: json["total"],
            totalPages: json["total_pages"],
            data: json["data"] == null ? [] : List<User>.from(json["data"]!.map((x) => User.fromJson(x))),
            
        );
    }

    @override
  List<Object?> get props => [page,total,perPage,totalPages,data];

}
