part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
  
  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}


class LoadingUsersState extends UsersState {}

class LoadedUsersState extends UsersState {
  final Users users;

  const LoadedUsersState({required this.users});

  @override
  List<Object> get props => [users.page!,users.totalPages!];

}

class ErrorUsersState extends UsersState {
  final String message;

  const ErrorUsersState({required this.message});

  @override
  List<Object> get props => [message];
}