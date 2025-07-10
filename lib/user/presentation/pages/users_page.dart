import 'package:clean_architecture_posts_app/core/widgets/circular_image_widget.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/core/widgets/message_display_widget.dart';
import 'package:clean_architecture_posts_app/user/domain/entities/users.dart';
import 'package:clean_architecture_posts_app/user/presentation/bloc/users/users_bloc.dart';
import 'package:clean_architecture_posts_app/user/presentation/pages/user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatefulWidget {

  const UsersPage({
    super.key,
  });
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  Users ?_users;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is LoadingUsersState) {
            return const LoadingWidget();
          } else if (state is LoadedUsersState) {
            _users = state.users;
            return ListView.separated(
              itemCount: state.users.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${state.users.data[index].firstName!} ${state.users.data[index].lastName!}',style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(state.users.data[index].email),
                  leading: CircularImageWidget(image: state.users.data[index].avatar!),
                  onTap: () {
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserDetailsPage(id: state.users.data[index].id),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          } else if (state is ErrorUsersState) {
            return MessageDisplayWidget(
              message: state.message,
              onRetry: () {
                _onRefresh();
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<UsersBloc>(context)
        .add(RefreshUsersEvent(users: _users));
  }
}
