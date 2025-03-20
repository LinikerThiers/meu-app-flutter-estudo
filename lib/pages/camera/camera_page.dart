import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadProfileImage(); // Carregar imagem ao iniciar
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString("profile_image");
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: source);

    if (photo != null) {
      String path =
          (await path_provider.getApplicationDocumentsDirectory()).path;
      String name = basename(photo.path);
      File savedImage = File("$path/$name");

      await photo.saveTo(savedImage.path);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          "profile_image", savedImage.path); // Salva o caminho da imagem

      setState(() {
        _profileImage = savedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("GALERIA".tr()),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: TextButton(
                  onPressed: () {
                    final ImagePicker picker = ImagePicker();
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        context: context,
                        builder: (BuildContext bc) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                            child: Wrap(
                              children: [
                                ListTile(
                                  onTap: () async {
                                    _pickImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  title: Text("CAMERA".tr()),
                                  leading: Icon(Icons.camera_alt),
                                ),
                                ListTile(
                                  onTap: () async {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                  title: Text("GALERIA".tr()),
                                  leading: Icon(Icons.photo_album),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Text("GALERIA".tr())))
        ],
      ),
    ));
  }
}
