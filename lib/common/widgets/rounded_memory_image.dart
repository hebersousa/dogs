import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class RoundedMemoryImage extends StatelessWidget {
  final Uint8List image;
  const RoundedMemoryImage({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Image.memory(image),
      ),
    );
  }
}
