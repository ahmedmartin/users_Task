import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/error/error_message.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/user/domain/entities/users.dart';
import 'package:clean_architecture_posts_app/user/domain/usecases/get_all_user_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {

  final GetAllUsersUseCase getAllUsersUseCase;
  UsersBloc({required this.getAllUsersUseCase})
      : super(UsersInitial()) {
    on<UsersEvent>((event, emit) async {
      if (event is GetAllUsersEvent) {
        emit(LoadingUsersState());

        final failureOrPosts =
            await getAllUsersUseCase(page: event.page);
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshUsersEvent) {
        emit(LoadingUsersState());

        final failureOrPosts =
            await getAllUsersUseCase(page: event.page);
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  UsersState _mapFailureOrPostsToState(Either<Failure, Users> either) {
    return either.fold(
      (failure) => ErrorUsersState(message: mapFailureToMessage(failure)),
      (users) => LoadedUsersState(
        users: users,
      ),
    );
  }
}
