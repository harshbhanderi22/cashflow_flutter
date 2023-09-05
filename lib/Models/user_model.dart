// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  String? name;
  String? email;
  String? image;
  double total;
  double cost;
  List<String>? income_cat;
  List<String>? expense_cat;
  String? company_name;
  UserModel({
    this.name,
    this.email,
    this.image,
    required this.total,
    required this.cost,
    this.income_cat,
    this.expense_cat,
    this.company_name,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? image,
    double? total,
    double? cost,
    List<String>? income_cat,
    List<String>? expense_cat,
    String? company_name,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      total: total ?? this.total,
      cost: cost ?? this.cost,
      income_cat: income_cat ?? this.income_cat,
      expense_cat: expense_cat ?? this.expense_cat,
      company_name: company_name ?? this.company_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'image': image,
      'total': total,
      'cost': cost,
      'income_cat': income_cat,
      'expense_cat': expense_cat,
      'company_name': company_name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      total: map['total'] as double,
      cost: map['cost'] as double,
      income_cat: map['income_cat'] != null ? List<String>.from((map['income_cat'] as List<String>)) : null,
      expense_cat: map['expense_cat'] != null ? List<String>.from((map['expense_cat'] as List<String>)) : null,
      company_name: map['company_name'] != null ? map['company_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, image: $image, total: $total, cost: $cost, income_cat: $income_cat, expense_cat: $expense_cat, company_name: $company_name)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.image == image &&
      other.total == total &&
      other.cost == cost &&
      listEquals(other.income_cat, income_cat) &&
      listEquals(other.expense_cat, expense_cat) &&
      other.company_name == company_name;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      image.hashCode ^
      total.hashCode ^
      cost.hashCode ^
      income_cat.hashCode ^
      expense_cat.hashCode ^
      company_name.hashCode;
  }
}
