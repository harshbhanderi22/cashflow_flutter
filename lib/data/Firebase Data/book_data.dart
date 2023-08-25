import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class StoreBookDataToUser {
  final firebaseFirestore = FirebaseFirestore.instance.collection("user");
  final dynamic mail = FirebaseAuth.instance.currentUser!.email;

  Future<void> addBook(Map<String, dynamic> data) async {
    try {
      QuerySnapshot queryShot =
          await firebaseFirestore.doc(mail).collection("books").get();
      int index = queryShot.docs.length;
      data["id"] = index + 1;
      firebaseFirestore
          .doc(mail)
          .collection("books")
          .doc((index + 1).toString())
          .set(data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> updateBook(Map<String, dynamic> data, String id) async {
    try {
      firebaseFirestore.doc(mail).collection("books").doc(id).set(data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> deleteBook(dynamic id) async {
    await firebaseFirestore
        .doc(mail)
        .collection("books")
        .doc(id.toString())
        .delete();
    print("Dleting");
  }
}
