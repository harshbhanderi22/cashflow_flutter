import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khatabook/Models/book_model.dart';
import 'package:khatabook/Utils/Routes/route_name.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/data/Firebase%20Data/book_data.dart';
import 'package:khatabook/view_model/home_screen_provider.dart';
import 'package:provider/provider.dart';

class BookFormProvider with ChangeNotifier {
  //0 = Customer
  //1 = Merchant

  int _selectedOption = 0;
  String _pickedImageUrl = "";
  File? _imageFile;
  bool _loading = false;
  bool _submitLoading = false;

  int get getSelectedOption => _selectedOption;
  String get getPickedImageUrl => _pickedImageUrl;
  File? get getPickedImage => _imageFile;
  bool get getImageLoading => _loading;
  bool get getSubmitLoading => _submitLoading;

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

  void setImageLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setSubmitLoading(bool value) {
    _submitLoading = value;
    notifyListeners();
  }

  Future<void> pickImage() async {
    setImageLoading(true);
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
        setImageLoading(false);
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
        setImageLoading(false);
        GeneralUtils.showToast("Image Failed To Fetch. Please Try Again");
      }
    }
  }

  void addData(BookModel bookModel, BuildContext context) {
    setSubmitLoading(true);
    try {
      StoreBookDataToUser().addBook(bookModel.toMap()).whenComplete(() {
        Navigator.of(context).popUntil((route) {
          Provider.of<HomePageProvider>(context,listen: false).fetchCustomerList();
          return true;
        });
        setPickedImage(null);
        setSelectedImageUrl("");
      });
      setSubmitLoading(false);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setSubmitLoading(false);
      GeneralUtils.showToast("Failed To Add Data. Try Again!!");
      Navigator.pop(context);
    }
  }

  void updateData(BookModel bookModel, String? id, BuildContext context) {
    try {
      StoreBookDataToUser().updateBook(bookModel.toMap(), id!).whenComplete(() {
        Navigator.of(context).pushNamed(RouteNames.home);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
