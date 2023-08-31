import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class LoadingImage extends StatelessWidget {
  const LoadingImage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Container(
              height: 300,
              child: const Icon(Icons.pets)
  );
}


class RoundedCachedImage extends StatelessWidget {
  final String url;
  const RoundedCachedImage({required this.url, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: url,
        placeholder: (context, url) => const LoadingImage(),
        errorWidget: (context, url, error) => const LoadingImage(),
      ),
    );
  }
}
