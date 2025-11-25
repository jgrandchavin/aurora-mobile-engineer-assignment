import 'package:flutter/material.dart';

class HomePageImage extends StatelessWidget {
  final String imageUrl;

  const HomePageImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          image: imageUrl.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 30,
              spreadRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
