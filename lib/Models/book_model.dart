// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookModel {
  final String name;
  final String type;
  final String address;
  final String? image;
  final String mobile;
  final dynamic id;
  BookModel({
    required this.name,
    required this.type,
    required this.address,
    this.image,
    required this.mobile,
    required this.id,
  });

  BookModel copyWith({
    String? name,
    String? type,
    String? address,
    String? image,
    String? mobile,
    dynamic id,
  }) {
    return BookModel(
      name: name ?? this.name,
      type: type ?? this.type,
      address: address ?? this.address,
      image: image ?? this.image,
      mobile: mobile ?? this.mobile,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
      'address': address,
      'image': image,
      'mobile': mobile,
      'id': id,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      name: map['name'] as String,
      type: map['type'] as String,
      address: map['address'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      mobile: map['mobile'] as String,
      id: map['id'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookModel(name: $name, type: $type, address: $address, image: $image, mobile: $mobile, id: $id)';
  }

  @override
  bool operator ==(covariant BookModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.type == type &&
        other.address == address &&
        other.image == image &&
        other.mobile == mobile &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        address.hashCode ^
        image.hashCode ^
        mobile.hashCode ^
        id.hashCode;
  }
}
