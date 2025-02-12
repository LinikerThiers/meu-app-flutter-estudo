import 'package:flutter/material.dart';
import 'package:trilhaapp/shared/app_images.dart';

class ImageAssetsPage extends StatefulWidget {
  const ImageAssetsPage({super.key});

  @override
  State<ImageAssetsPage> createState() => _ImageAssetsPageState();
}

class _ImageAssetsPageState extends State<ImageAssetsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.plymouth,
          height: 100,
        ),
        Image.asset(
          AppImages.plymouthStadium,
          width: double.infinity,
        ),
        Image.asset(
          AppImages.derby,
          height: 100,
        ),
        Image.asset(
          AppImages.derbyStadium,
          width: double.infinity,
        ),
      ],
    );
  }
}
