import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatabook/Models/book_model.dart';

class UserData {
  Future<void> addUser(
      Map<String, dynamic> data, String collection, String? doc) async {
    final firebaseFirestore = FirebaseFirestore.instance.collection(collection);
    firebaseFirestore.doc(doc).set(data);
  }

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
          balance: e["balance"]
          );
    }).toList();
    return books;
  }
}
