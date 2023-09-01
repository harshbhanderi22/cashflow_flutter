// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

  
class TransactionModel {
  String title;
  String category;
  double cost;
  double total;
  String date;
  String time;
  String id;
  TransactionModel({
    required this.title,
    required this.category,
    required this.cost,
    required this.total,
    required this.date,
    required this.time,
    required this.id,
  });

  TransactionModel copyWith({
    String? title,
    String? category,
    double? cost,
    double? total,
    String? date,
    String? time,
    String? id,
  }) {
    return TransactionModel(
      title: title ?? this.title,
      category: category ?? this.category,
      cost: cost ?? this.cost,
      total: total ?? this.total,
      date: date ?? this.date,
      time: time ?? this.time,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'category': category,
      'cost': cost,
      'total': total,
      'date': date,
      'time': time,
      'id': id,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      title: map['title'] as String,
      category: map['category'] as String,
      cost: map['cost'] as double,
      total: map['total'] as double,
      date: map['date'] as String,
      time: map['time'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(title: $title, category: $category, cost: $cost, total: $total, date: $date, time: $time, id: $id)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.category == category &&
      other.cost == cost &&
      other.total == total &&
      other.date == date &&
      other.time == time &&
      other.id == id;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      category.hashCode ^
      cost.hashCode ^
      total.hashCode ^
      date.hashCode ^
      time.hashCode ^
      id.hashCode;
  }
}
