import 'package:clean_architecture_posts_app/user/presentation/bloc/user/user_bloc.dart';
import 'package:clean_architecture_posts_app/user/presentation/bloc/users/users_bloc.dart';
import 'package:clean_architecture_posts_app/user/presentation/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<UsersBloc>()..add(const GetAllUsersEvent())),
          BlocProvider(
              create: (_) => di.sl<UserBloc>()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            title: 'Products App',
            home: const UsersPage()));
  }
}
