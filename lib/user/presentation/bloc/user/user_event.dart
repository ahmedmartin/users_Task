part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}


class GetUserEvent extends UserEvent {
  final int id;

  const GetUserEvent({required this.id});
}

class RefreshUserEvent extends UserEvent {
  final int id;

  const RefreshUserEvent({required this.id});
}