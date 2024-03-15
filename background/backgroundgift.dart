import 'package:flutter/material.dart';

class BackgroundGif extends StatelessWidget {
  final String gifPath;

  BackgroundGif({required this.gifPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(gifPath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}