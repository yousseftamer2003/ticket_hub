import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageController with ChangeNotifier {
  String? _base64Image; 
  File? _imageFile; 

  String? get base64Image => _base64Image;
  File? get imageFile => _imageFile;

  Future<void> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        _base64Image = base64Encode(await _imageFile!.readAsBytes());
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void clearImage() {
    _imageFile = null;
    _base64Image = null;
    notifyListeners();
  }
}
