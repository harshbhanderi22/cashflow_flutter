import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khatabook/Models/book_model.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
import 'package:khatabook/data/Firebase%20Data/book_data.dart';

class BookFormProvider with ChangeNotifier {
  //0 = Customer
  //1 = Merchant

  int _selectedOption = 0;
  String _pickedImageUrl = "https://freesvg.org/img/abstract-user-flat-4.png";
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

      Reference referenceroot = FirebaseStorage.instance.ref();
      Reference referenceToDir = referenceroot.child('images');
      Reference referenceToImage = referenceToDir.child(uniqueName);
      try {
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

  void addData(BookModel bookModel, BuildContext context) {
    try {
      StoreBookDataToUser().addBook(bookModel.toMap()).whenComplete(() {
        Navigator.of(context).pushNamed(RouteNames.home);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void updateData(BookModel bookModel,String id, BuildContext context) {
    try {
      StoreBookDataToUser()
          .updateBook(bookModel.toMap(),id)
          .whenComplete(() {
        Navigator.of(context).pushNamed(RouteNames.home);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  
}