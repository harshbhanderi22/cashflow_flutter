import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:khatabook/Models/transaction_model.dart';

class TransactionData {
  final firebaseFirestore = FirebaseFirestore.instance.collection("user");
  final dynamic mail = FirebaseAuth.instance.currentUser!.email;

  Future<void> addData(Map<String, dynamic> data, dynamic docId) async {
    dynamic id = data["id"];
    try {
      await firebaseFirestore
          .doc(mail)
          .collection("books")
          .doc(id)
          .collection("transaction")
          .doc(id)
          .set(data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> updateBook(
      Map<String, dynamic> data, String docId, String id) async {
    try {
      await firebaseFirestore
          .doc(mail)
          .collection("books")
          .doc(docId)
          .collection("transaction")
          .doc(id)
          .set(data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> deleteBook(String docId, String id) async {
    try {
      await firebaseFirestore
          .doc(mail)
          .collection("books")
          .doc(docId)
          .collection("transaction")
          .doc(id)
          .delete();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<TransactionModel>> getAllTransactions(dynamic docId) async {
    final user = FirebaseAuth.instance.currentUser!.email;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore
        .collection("user")
        .doc(user!)
        .collection("books")
        .doc(docId)
        .collection("transaction")
        .orderBy("id")
        .get();

    dynamic transactions = snapshot.docs.map((e) {
      return TransactionModel(
          title: e["title"],
          category: e["category"],
          cost: e["cost"],
          total: e["total"],
          date: e["date"],
          time: e["time"],
          id: e["id"]);
    }).toList();
    return transactions;
  }
}
