// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CustomerModel {
  final String name;
  final String type;
  final String address;
  final String? image;
  final String mobile;
  CustomerModel({
    required this.name,
    required this.type,
    required this.address,
    this.image,
    required this.mobile,
  });
  

   

  CustomerModel copyWith({
    String? name,
    String? type,
    String? address,
    String? image,
    String? mobile,
  }) {
    return CustomerModel(
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      image: image ?? this.image,
      mobile: mobile ?? this.mobile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'address': address,
      'image': image,
      'mobile': mobile,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      name: map['name'] as String,
      type: map['type'] as String,
      address: map['address'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      mobile: map['mobile'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) => CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerModel(name: $name, type: $type, address: $address, image: $image, mobile: $mobile)';
  }

  @override
  bool operator ==(covariant CustomerModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.type == type &&
      other.address == address &&
      other.image == image &&
      other.mobile == mobile;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      type.hashCode ^
      address.hashCode ^
      image.hashCode ^
      mobile.hashCode;
  }
}
