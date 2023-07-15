import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatabook/Models/customer_model.dart';

class UserData {
  Future<void> addUser(
      Map<String, dynamic> data, String collection, String? doc) async {
    final firebaseFirestore = FirebaseFirestore.instance.collection(collection);
    firebaseFirestore.doc(doc).set(data);
  }

  Future<List<CustomerModel>> getAllCustomers() async {
    final user = FirebaseAuth.instance.currentUser!.email;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore
        .collection("user")
        .doc(user!)
        .collection("customer")
        .get();

    final List<CustomerModel> customers = snapshot.docs.map((doc) {
      final data = doc.data();

      return CustomerModel();
    }).toList();

    return customers;
  }
}
