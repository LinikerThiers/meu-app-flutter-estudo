import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_cropper/image_cropper.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _profileImage;

  /// Recorta a imagem selecionada e retorna o arquivo final.
  Future<File?> cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 1500, //optional if you want to control the width (max)
      maxHeight: 1500,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.purple,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor:
              Colors.purple, // Ícones e controles inferiores
          statusBarColor: Colors.purple, // Cor da status bar
          backgroundColor: Colors.black, // Fundo do cropper
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
      ],
    );

    if (croppedFile == null) return null; // Usuário cancelou o crop

    return File(croppedFile.path);
  }

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  /// Carrega a imagem salva no dispositivo.
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString("profile_image");
    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  /// Permite ao usuário escolher uma imagem da câmera ou galeria e salva apenas após o corte.
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: source);

    if (photo == null) return; // Se o usuário cancelar, não faz nada

    File? croppedImage = await cropImage(photo);

    if (croppedImage == null) return; // Se o usuário cancelar o crop, não salva

    // Salvar apenas a imagem recortada
    String path = (await path_provider.getApplicationDocumentsDirectory()).path;
    String name = basename(croppedImage.path);
    File savedImage = File("$path/$name");

    await croppedImage.copy(savedImage.path);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("profile_image", savedImage.path); // Salva o caminho

    setState(() {
      _profileImage = savedImage;
    });
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
                                await _pickImage(ImageSource.camera);
                                Navigator.pop(context);
                              },
                              title: Text("CAMERA".tr()),
                              leading: Icon(Icons.camera_alt),
                            ),
                            ListTile(
                              onTap: () async {
                                await _pickImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              title: Text("GALERIA".tr()),
                              leading: Icon(Icons.photo_album),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text("GALERIA".tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
