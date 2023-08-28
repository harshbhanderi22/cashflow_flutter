// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_button.dart';
import 'package:provider/provider.dart';

import 'package:khatabook/Models/book_model.dart';
import 'package:khatabook/Utils/Components/common_form_field.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/constant.dart';
import 'package:khatabook/Utils/general_utils.dart';
import 'package:khatabook/view_model/book_form_provider.dart';

class AddBookScreen extends StatefulWidget {
  final BookModel? bookModel;
  final bool edit;
  final String? id;

  const AddBookScreen({super.key, this.bookModel, required this.edit, this.id});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.bookModel != null) {
      _nameController.text = widget.bookModel!.name;
      _addressController.text = widget.bookModel!.address;
      _mobileController.text = widget.bookModel!.mobile;
    }
  }

  double balance = 0;

  Future<void> getBalance() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("ad")
        .doc("eZygQLXU4BFNvSkqd2v2")
        .get();

    balance = snapshot.get('balance');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Add Person"),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Consumer<BookFormProvider>(builder: (context, value, child) {
                    return CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      radius: 50,
                      child: ClipOval(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: value.getPickedImage == null
                              ? const Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 36,
                                )
                              : value.getImageLoading
                                  ? const CircularProgressIndicator()
                                  : Image.file(
                                      value.getPickedImage!,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    width: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<BookFormProvider>(
                          builder: (context, value, child) {
                        return InkWell(
                          onTap: () {
                            widget.edit
                                ? GeneralUtils.showToast(
                                    "Editing Image Coming Soon")
                                : value.pickImage();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: blue),
                            child: const CommonText(
                              text: "Upload Photo",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontsize: 16,
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: GeneralUtils.getWidth(context) / 1.8,
                        child: const CommonText(
                            fontsize: 12,
                            text:
                                "It is not mandatory but still encourage you to upload photo for better user experience"),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Consumer<BookFormProvider>(
                          builder: (context, value, child) {
                        return Radio(
                            activeColor: lightBlue,
                            value: 0,
                            groupValue: value.getSelectedOption,
                            onChanged: (val) {
                              value.setSelectedOption(0);
                            });
                      }),
                      const CommonText(fontsize: 16, text: "Customer"),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Row(
                    children: [
                      Consumer<BookFormProvider>(
                          builder: (context, value, child) {
                        return Radio(
                            activeColor: lightBlue,
                            value: 1,
                            groupValue: value.getSelectedOption,
                            onChanged: (val) {
                              value.setSelectedOption(1);
                            });
                      }),
                      const CommonText(fontsize: 16, text: "Merchant"),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CommonFormField(
                controller: _nameController,
                hint: "Enter Name",
              ),
              CommonFormField(
                controller: _mobileController,
                hint: "Enter Mobile Number",
              ),
              CommonFormField(
                controller: _addressController,
                hint: "Enter Address",
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<BookFormProvider>(builder: (context, value, child) {
                return InkWell(
                  onTap: () async {
                    DateTime currentTime = await DateTime.now();
                    BookModel cm = BookModel(
                        image: value.getPickedImageUrl,
                        name: _nameController.text,
                        type: value.getSelectedOption == 0
                            ? "Customer"
                            : "Merchant",
                        address: _addressController.text,
                        balance: balance.toString(),
                        mobile: _mobileController.text,
                        id: currentTime.toString());

                    BookModel cm2 = BookModel(
                        image: value.getPickedImageUrl,
                        name: _nameController.text,
                        type: value.getSelectedOption == 0
                            ? "Customer"
                            : "Merchant",
                        address: _addressController.text,
                        balance: balance.toString(),
                        mobile: _mobileController.text,
                        id: widget.id);
                    widget.edit == true
                        ? value.updateData(cm2, widget.id, context)
                        : value.addData(cm, context);
                  },
                  child: CommonButton(
                    child: Center(
                        child: value.getSubmitLoading
                            ? const CircularProgressIndicator()
                            : CommonButtonText(
                              label: "Add Book",
                            )),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
  }
}


