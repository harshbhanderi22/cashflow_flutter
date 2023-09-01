import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khatabook/Models/book_model.dart';
import 'package:khatabook/view_model/home_screen_provider.dart';
import 'package:provider/provider.dart';

class UserData {
  Future<void> addUser(
      Map<String, dynamic> data, String collection, String? doc) async {
    final firebaseFirestore = FirebaseFirestore.instance.collection(collection);
    firebaseFirestore.doc(doc).set(data);
  }

  final mail = FirebaseAuth.instance.currentUser!.email;

  Future<List<BookModel>> getAllCustomers() async {
    final user = FirebaseAuth.instance.currentUser!.email;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot =
        await firestore.collection("user").doc(user!).collection("books").orderBy("id").get();

    dynamic books = snapshot.docs.map((e) {
      return BookModel(
          id: e["id"],
          name: e["name"],
          type: e["type"],
          address: e["address"],
          mobile: e["mobile"],
          image: e["image"],
          total:e["total"],
          cost: e["cost"]
          );
    }).toList();
    return books;
  }

   Future<double> calculateTotalBookSum(BuildContext context) async {
    double totalSum = 0;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore
        .collection("user")
        .doc(mail!)
        .collection("books")
        .get();

    List<BookModel> books = snapshot.docs.map((e) {
       return BookModel(
          id: e["id"],
          name: e["name"],
          type: e["type"],
          address: e["address"],
          mobile: e["mobile"],
          image: e["image"],
          total:e["total"],
          cost: e["cost"]
          );
    }).toList();

    for (int i = 0; i < books.length; i++) {
      totalSum += books[i].total;
    }

    await FirebaseFirestore.instance
        .collection("user")
        .doc(mail)
        .update({"total": totalSum});

           Future.microtask(() {
  Provider.of<HomePageProvider>(context, listen: false).setIncome(totalSum);
});

  
  // final provider = Provider.of<HomePageProvider>(context, listen: false);
  // provider.setIncome(totalSum);
    return totalSum;
  }


Future<double> calculateTotalBookCost(BuildContext context) async {
    double totalSum = 0;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore
        .collection("user")
        .doc(mail!)
        .collection("books")
        .get();

    List<BookModel> books = snapshot.docs.map((e) {
       return BookModel(
          id: e["id"],
          name: e["name"],
          type: e["type"],
          address: e["address"],
          mobile: e["mobile"],
          image: e["image"],
          total:e["total"],
          cost: e["cost"]
          );
    }).toList();

    for (int i = 0; i < books.length; i++) {
      totalSum += books[i].cost;
    }

    await FirebaseFirestore.instance
        .collection("user")
        .doc(mail)
        .update({"cost": totalSum});

   Future.microtask(() {
  Provider.of<HomePageProvider>(context, listen: false).setExpense(totalSum);
});
 
  return totalSum;
  }



  
}
