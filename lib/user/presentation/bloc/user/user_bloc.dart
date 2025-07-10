import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/error/error_message.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/user/domain/entities/user.dart';
import 'package:clean_architecture_posts_app/user/domain/usecases/get_user_by_id_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserByIdUseCase getUserUseCase;
  UserBloc({required this.getUserUseCase}) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is GetUserEvent) {
        emit(LoadingUserState());

        final failureOrPosts = await getUserUseCase(id: event.id);
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshUserEvent) {
        emit(LoadingUserState());

        final failureOrPosts = await getUserUseCase(id: event.id);
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  UserState _mapFailureOrPostsToState(Either<Failure, User> either) {
    return either.fold(
      (failure) => ErrorUserState(message: mapFailureToMessage(failure)),
      (uer) => LoadedUserState(
        user: uer,
      ),
    );
  }
}
