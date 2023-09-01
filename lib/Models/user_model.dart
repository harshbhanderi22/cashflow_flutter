// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String? name;
  String? email;
  String? image;
  double total;
  double cost;
  UserModel({
    this.name,
    this.email,
    this.image,
    required this.total,
    required this.cost,
  });

   

  UserModel copyWith({
    String? name,
    String? email,
    String? image,
    double? total,
    double? cost,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      total: total ?? this.total,
      cost: cost ?? this.cost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'image': image,
      'total': total,
      'cost': cost,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      total: map['total'] as double,
      cost: map['cost'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, image: $image, total: $total, cost: $cost)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.image == image &&
      other.total == total &&
      other.cost == cost;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      image.hashCode ^
      total.hashCode ^
      cost.hashCode;
  }
}
