import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Models/transaction_model.dart';
import 'package:khatabook/data/Firebase%20Data/user_data.dart';
import 'package:khatabook/view_model/home_screen_provider.dart';
import 'package:provider/provider.dart';

class TransactionData {
  final firebaseFirestore = FirebaseFirestore.instance.collection("user");
  final dynamic mail = FirebaseAuth.instance.currentUser!.email;

  Future<void> addData(Map<String, dynamic> data, dynamic docId) async {
    dynamic id = data["id"];
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

  Future<double> calculateTotalSum(dynamic docId, BuildContext context) async {
    double totalSum = 0;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore
        .collection("user")
        .doc(mail!)
        .collection("books")
        .doc(docId)
        .collection("transaction")
        .orderBy("id")
        .get();

    List<TransactionModel> transactions = snapshot.docs.map((e) {
      return TransactionModel(
          title: e["title"],
          category: e["category"],
          cost: e["cost"],
          total: e["total"],
          date: e["date"],
          time: e["time"],
          recieved: e["recieved"],
          id: e["id"]);
    }).toList();

    for (int i = 0; i < transactions.length; i++) {
      totalSum += transactions[i].total;
    }

    await FirebaseFirestore.instance
        .collection("user")
        .doc(mail)
        .collection("books")
        .doc(docId)
        .update({"total": totalSum});

    final provider = Provider.of<HomePageProvider>(context, listen: false);
    provider.updateBookTotal(docId, totalSum);
    UserData().calculateTotalBookSum(context);
    return totalSum;
  }

  Future<double> calculateTotatCost(dynamic docId, BuildContext context) async {
    double totalCost = 0;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore
        .collection("user")
        .doc(mail!)
        .collection("books")
        .doc(docId)
        .collection("transaction")
        .orderBy("id")
        .get();

    List<TransactionModel> transactions = snapshot.docs.map((e) {
      return TransactionModel(
          title: e["title"],
          recieved: e["recieved"],

          category: e["category"],
          cost: e["cost"],
          total: e["total"],
          date: e["date"],
          time: e["time"],
          id: e["id"]);
    }).toList();

    for (int i = 0; i < transactions.length; i++) {
      totalCost += transactions[i].cost;
    }

    await FirebaseFirestore.instance
        .collection("user")
        .doc(mail)
        .collection("books")
        .doc(docId)
        .update({"cost": totalCost});

    final provider = Provider.of<HomePageProvider>(context, listen: false);
    provider.updateBookCost(docId, totalCost);

    UserData().calculateTotalBookCost(context);

    return totalCost;
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
        .orderBy("id", descending: true)
        .get();

    dynamic transactions = snapshot.docs.map((e) {
      return TransactionModel(
          title: e["title"],
          recieved: e["recieved"],

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
