

import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class CircularImageWidget extends StatelessWidget{
  final double ?redius;
  final String image;

  const CircularImageWidget({super.key, this.redius, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                          height: redius??150,
                          width: redius??150,
                          child: Image.network(image,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const LoadingWidget();
                          }),
                        );
  }
}