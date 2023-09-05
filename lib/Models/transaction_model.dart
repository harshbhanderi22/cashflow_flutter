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
  double recieved;
  TransactionModel({
    required this.title,
    required this.category,
    required this.cost,
    required this.total,
    required this.date,
    required this.time,
    required this.id,
    required this.recieved,
  });

  TransactionModel copyWith({
    String? title,
    String? category,
    double? cost,
    double? total,
    String? date,
    String? time,
    String? id,
    double? recieved,
  }) {
    return TransactionModel(
      title: title ?? this.title,
      category: category ?? this.category,
      cost: cost ?? this.cost,
      total: total ?? this.total,
      date: date ?? this.date,
      time: time ?? this.time,
      id: id ?? this.id,
      recieved: recieved ?? this.recieved,
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
      'recieved': recieved,
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
      recieved: map['recieved'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(title: $title, category: $category, cost: $cost, total: $total, date: $date, time: $time, id: $id, recieved: $recieved)';
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
      other.id == id &&
      other.recieved == recieved;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      category.hashCode ^
      cost.hashCode ^
      total.hashCode ^
      date.hashCode ^
      time.hashCode ^
      id.hashCode ^
      recieved.hashCode;
  }
}
