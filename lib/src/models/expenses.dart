// ignore_for_file: annotate_overrides, overridden_fields, file_names

import 'package:budget/src/models/model.dart';

class ExpenseModel extends Model {
  ExpenseModel({
    this.expenses,
    this.id,
    this.month,
    this.createdBy,
    DateTime? dateCreated,
  }) : super('expenses','expenses') {
    this.dateCreated = dateCreated ?? DateTime.now();
  }

  String? id;
  DateTime? month;
  List<Map<String, dynamic>>? expenses;
  late DateTime dateCreated;
  String? createdBy;

  ExpenseModel.fromMap(Map map) : super('expenses','expenses') {
    id = map['id'];
    month = DateTime.tryParse(map['month'].toString());
    expenses = List.from(map['expenses'])
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    dateCreated =
        DateTime.tryParse(map['dateCreated'].toString()) ?? DateTime.now();
    createdBy = map['createdBy'];
  }
  Map<String, dynamic> asMap() {
    return {
      'expenses': expenses,
      'month': month?.toIso8601String(),
      'dateCreated': dateCreated.toIso8601String(),
      'createdBy': createdBy,
    };
  }
}
