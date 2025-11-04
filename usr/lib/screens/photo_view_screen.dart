import 'package:flutter/material.dart';

class PhotoViewScreen extends StatelessWidget {
  final String imagePath;
  final String imageTag;

  const PhotoViewScreen({
    super.key, 
    required this.imagePath,
    required this.imageTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: imageTag,
          child: Image.asset(
            imagePath,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
