part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class LoadingUserState extends UserState {}

class LoadedUserState extends UserState {
  final User user;

  const LoadedUserState({required this.user});

}

class ErrorUserState extends UserState {
  final String message;

  const ErrorUserState({required this.message});

  @override
  List<Object> get props => [message];
}