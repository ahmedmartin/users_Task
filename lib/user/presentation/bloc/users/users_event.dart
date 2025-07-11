part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}


class GetAllUsersEvent extends UsersEvent {
  final  Users ?users;

  const GetAllUsersEvent({this.users});

  int get  page {
    if(users != null){
       if(users!.page != users!.totalPages){
        return (users!.page!)+1;
       }else{
        return 0;
       }
    }else {
      return 1;
    }
  }
}

class RefreshUsersEvent extends UsersEvent {
  final  Users ?users;

  const RefreshUsersEvent({this.users});

  int get  page {
    if(users != null){
       if(users!.page == users!.totalPages){
        return 0;
       }else{
        return (users!.page!)+1;
       }
    }else {
      return 1;
    }
  }
}


