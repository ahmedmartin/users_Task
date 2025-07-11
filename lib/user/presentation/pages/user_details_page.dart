import 'package:clean_architecture_posts_app/core/widgets/circular_image_widget.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/core/widgets/message_display_widget.dart';
import 'package:clean_architecture_posts_app/user/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsPage extends StatefulWidget {
  final int id;

  const UserDetailsPage({super.key, required this.id});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(GetUserEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is LoadingUserState) {
            return const LoadingWidget();
          } else if (state is LoadedUserState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  CircularImageWidget(image: state.user.avatar!,redius: 200,),
                  const SizedBox(height: 20,),
                  Center(
                      child: Text(state.user.email,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListTile(
                          title: const Text('first name',
                              style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(state.user.firstName!),
                        ),
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListTile(
                          title: const Text('last name',
                              style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(state.user.lastName!),
                        ),
                      ),

                    ],
                  ),
                  
                ],
              ),
            );
          } else if (state is ErrorUserState) {
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
    BlocProvider.of<UserBloc>(context)
        .add(RefreshUserEvent(id: widget.id));
  }
}
