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
            return SizedBox();
            // return SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       const SizedBox(
            //         height: 40,
            //       ),
            //       Center(
            //           child: Text(state.user.title,
            //               style: const TextStyle(
            //                   fontWeight: FontWeight.bold, fontSize: 20))),
            //       SizedBox(
            //         height: 150,
            //         child: ListView.separated(
            //           scrollDirection: Axis.horizontal,
            //           itemCount: state.user.images.length,
            //           itemBuilder: (context, index) {
            //             return Container(
            //               height: 150,
            //               width: 150,
            //               child: Image.network(state.user.images[index],
            //                   loadingBuilder:
            //                       (context, child, loadingProgress) {
            //                 if (loadingProgress == null) return child;
            //                 return const LoadingWidget();
            //               }),
            //             );
            //           },
            //           separatorBuilder: (BuildContext context, int index) =>
            //               const VerticalDivider(
            //             color: Colors.grey,
            //           ),
            //         ),
            //       ),
            //       const SizedBox(height: 10),
            //       ListTile(
            //         title: const Text('description',
            //             style: TextStyle(fontWeight: FontWeight.bold)),
            //         subtitle: Text(state.user.description),
            //       ),
            //       const SizedBox(height: 10),
            //       Row(
            //         children: [
            //           SizedBox(
            //             width: MediaQuery.of(context).size.width / 2,
            //             child: ListTile(
            //               title: const Text('price',
            //                   style:
            //                       TextStyle(fontWeight: FontWeight.bold)),
            //               subtitle: Text(state.user.price.toString()),
            //             ),
            //           ),
            //           SizedBox(
            //             width: MediaQuery.of(context).size.width / 2,
            //             child: ListTile(
            //               title: const Text('quantity',
            //                   style:
            //                       TextStyle(fontWeight: FontWeight.bold)),
            //               subtitle: Text(
            //                   state.user.minimumOrderQuantity.toString()),
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 10),
            //       ListTile(
            //         title: const Text('rate',
            //             style: TextStyle(fontWeight: FontWeight.bold)),
            //         subtitle: Text(state.user.rating.toString()),
            //       ),
            //       const SizedBox(height: 10),
            //       ListTile(
            //         title: const Text('SKU',
            //             style: TextStyle(fontWeight: FontWeight.bold)),
            //         subtitle: Text(state.user.sku),
            //       ),
            //       const SizedBox(height: 10),
            //       ListTile(
            //         title: const Text('tags',
            //             style: TextStyle(fontWeight: FontWeight.bold)),
            //         subtitle: SizedBox(
            //           height: 20,
            //           child: ListView.separated(
            //               scrollDirection: Axis.horizontal,
            //               itemCount: state.user.tags.length,
            //               itemBuilder: (context, index) => Text(
            //                     state.user.tags[index],
            //                     style: const TextStyle(color: Colors.blue),
            //                   ),
            //               separatorBuilder: (BuildContext context, int index) =>
            //                   const SizedBox(
            //                     width: 10,
            //                   )),
            //         ),
            //       ),
            //       ListTile(
            //         title: const Text('reviews',
            //             style: TextStyle(fontWeight: FontWeight.bold)),
            //         subtitle: SizedBox(
            //           height: 80,
            //           child: ListView.separated(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: state.user.reviews.length,
            //             itemBuilder: (context, index) => SizedBox(
            //                 width: 260,
            //                 child: ListTile(
            //                   contentPadding: const EdgeInsets.all(0),
            //                   title: Text(
            //                     state.user.reviews[index].reviewerEmail,
            //                     style:
            //                         const TextStyle(color: Colors.grey, fontSize: 14),
            //                   ),
            //                   subtitle: Text(
            //                       state.user.reviews[index].comment,
            //                       style: const TextStyle(
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: 16)),
            //                 )),
            //             separatorBuilder: (BuildContext context, int index) =>
            //                 const VerticalDivider(
            //               color: Colors.grey,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // );
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
