import 'package:equatable/equatable.dart';


class User extends Equatable{
   const User({
        required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.avatar,
    });

    final int id;
    final String email;
    final String? firstName;
    final String? lastName;
    final String? avatar;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["id"],
            email: json["email"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            avatar: json["avatar"],
        );
    }

    @override
  List<Object> get props => [id];

}
