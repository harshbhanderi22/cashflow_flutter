import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoreCustomerDataToUser {
  Future<void> addCustomer(Map<String,dynamic> data) async {
    final firebaseFirestore = FirebaseFirestore.instance.collection("user");
    firebaseFirestore.doc(FirebaseAuth.instance.currentUser!.email).collection("customer").add(data);
  }

}