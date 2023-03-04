import 'package:flutter/material.dart';

import '../../../models/problem_model.dart';

class OpenImageScreen extends StatelessWidget {
  const OpenImageScreen({super.key, this.imageUrl});
  final MAProblemModel? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              imageUrl!.imageUrl!,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
