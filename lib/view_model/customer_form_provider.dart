import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class CustomerFormProvider with ChangeNotifier {
  //0 = Customer
  //1 = Merchant

  int _selectedOption = 0;
  String _pickedImageUrl = "";
  File? _imageFile;

  int get getSelectedOption => _selectedOption;
  String get getPickedImageUrl => _pickedImageUrl;
  File? get getPickedImage => _imageFile;

  void setSelectedOption(int value) {
    _selectedOption = value;
    notifyListeners();
  }

  void setSelectedImageUrl(String url) {
    _pickedImageUrl = url;
    notifyListeners();
  }

  void setPickedImage(File? file) {
    _imageFile = file;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setPickedImage(File(pickedImage.path));
      var uniqueName = DateTime.now().microsecondsSinceEpoch.toString();

      //Upload in Firebase Storage
      //1. Create Reference to Root Directory
      Reference referenceroot = FirebaseStorage.instance.ref();
      //2. Create a reference to Directory in root directory
      Reference referenceToDir = referenceroot.child('images');
      //3. Create reference for image that is going to stored in base
      //Here we will provide name that we want to store in firebase
      Reference referenceToImage = referenceToDir.child(uniqueName);
      //Uploading Image
      try {
        //To Store Image in Firebase Storage
        await referenceToImage.putFile(File(_imageFile!.path));
        final downloadUrl = await referenceToImage.getDownloadURL();
        setSelectedImageUrl(downloadUrl);
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
  }
}
