import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String imageUrl;

  ImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Изображение'),
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.fill, // Растянуть изображение на всю ширину и высоту экрана
        ),
      ),
    );
  }
}
