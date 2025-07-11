import 'package:clean_architecture_posts_app/core/widgets/circular_image_widget.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/core/widgets/message_display_widget.dart';
import 'package:clean_architecture_posts_app/user/domain/entities/user.dart';
import 'package:clean_architecture_posts_app/user/domain/entities/users.dart';
import 'package:clean_architecture_posts_app/user/presentation/bloc/users/users_bloc.dart';
import 'package:clean_architecture_posts_app/user/presentation/pages/user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paginated_list/paginated_list.dart';

class UsersPage extends StatefulWidget {

  const UsersPage({
    super.key,
  });
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  Users ?_users;
  UsersBloc ?_bloc ;
  List<User> usersList = [];

  @override
  void initState() {
   _bloc = BlocProvider.of<UsersBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UsersBloc, UsersState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is LoadedUsersState) {
            _users = state.users;

            //use this to test pagination 
            // usersList =  [...usersList,...state.users.data,...state.users.data,...state.users.data];

            usersList =  [...usersList,...state.users.data];
            setState(() {
              
            });
          }
        },
        builder: (context, state) {
          if (state is LoadingUsersState) {
            return const LoadingWidget();
          } else if (state is LoadedUsersState) {
            
            return PaginatedList<User>(
          loadingIndicator: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
            child: CircularProgressIndicator(color: Colors.black),
        ),
          ),
          items: usersList,
          isRecentSearch: false,
          isLastPage: state.users.totalPages == state.users.page,
          onLoadMore: (index) {
             _bloc!.add(GetAllUsersEvent(users: _users));
          },
          builder: (movie, index) => ListTile(
                  title: Text('${usersList[index].firstName!} ${usersList[index].lastName!}',style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(usersList[index].email),
                  leading: CircularImageWidget(image: usersList[index].avatar!,padding: const EdgeInsets.symmetric(horizontal: 10),),
                  onTap: () {
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserDetailsPage(id: usersList[index].id),
                      ),
                    );
                  },
                ),
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
