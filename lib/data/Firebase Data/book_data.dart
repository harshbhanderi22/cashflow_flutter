import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class StoreBookDataToUser {
  final firebaseFirestore = FirebaseFirestore.instance.collection("user");
  final dynamic mail = FirebaseAuth.instance.currentUser!.email;

  Future<void> addBook(Map<String, dynamic> data) async {
    dynamic id = data["id"];
    try {
      await firebaseFirestore
          .doc(mail)
          .collection("books").doc(id)
          .set(data); // Use .add() to automatically generate a unique ID
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

  Future<void> deleteBook(String docId) async {
    await firebaseFirestore
        .doc(mail)
        .collection("books")
        .doc(docId) // Use the unique document ID
        .delete();
    //print("Deleting");
  }


}
