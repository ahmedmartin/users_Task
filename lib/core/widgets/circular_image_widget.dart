import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class CircularImageWidget extends StatelessWidget {
  final double? redius;
  final String image;
  final EdgeInsetsGeometry? padding;

  const CircularImageWidget({super.key, this.redius, required this.image, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: redius ?? 80,
      width: (redius ?? 80),
      padding: padding,
      decoration:
          const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.hardEdge,
      child: Image.network(image,fit: BoxFit.fill,
          loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const LoadingWidget();
      }),
    );
  }
}
