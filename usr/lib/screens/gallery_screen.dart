import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/photo_view_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  // IMPORTANT: Replace these with your actual image paths in 'assets/images/'
  // For this to work, you must create a folder named 'assets' in your project's
  // root directory, and inside 'assets', create another folder named 'images'.
  // Place your pictures inside 'assets/images/'.
  // Example: 'assets/images/our_first_date.jpg'
  final List<String> _imagePaths = const [
    'assets/images/image1.jpg',
    // Add more image paths here like:
    // 'assets/images/image2.jpg',
    // 'assets/images/image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Love Gallery', style: Theme.of(context).textTheme.headlineMedium),
        backgroundColor: const Color(0xFF1a1a2e),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _imagePaths.length,
        itemBuilder: (context, index) {
          final imagePath = _imagePaths[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoViewScreen(imagePath: imagePath, imageTag: 'galleryImage$index'),
                ),
              );
            },
            child: Hero(
              tag: 'galleryImage$index',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  // Error builder handles cases where an image might be missing
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
