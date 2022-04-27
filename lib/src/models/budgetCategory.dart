// ignore_for_file: annotate_overrides, overridden_fields, file_names

import 'model.dart';

class BudgetCategoryModel extends Model {
  BudgetCategoryModel(
      {this.id,
      this.budgets,
      this.createdBy,
      this.month,
      DateTime? dateCreated})
      : super('budgetCategory','') {
    this.dateCreated = dateCreated ?? DateTime.now();
  }
  String? id;  
  List<Map<String, dynamic>> ? budgets;
  late DateTime dateCreated;
  DateTime?  month;
  String? createdBy;
  BudgetCategoryModel.fromMap(Map map) : super('budgetCategory','') {
    id = map['id'];
    budgets = List.from(map['budgets']).map((e) => Map<String,dynamic>.from(e)).toList();
    month = DateTime.tryParse(map['month'].toString());
    createdBy = map['createdBy'];
    dateCreated =
        DateTime.tryParse(map['dateCreated'].toString()) ?? DateTime.now();
  }
  Map<String, dynamic> asMap() {
    return {
      'budgets': budgets,
      'createdBy': createdBy,
      'dateCreated': dateCreated.toIso8601String(),
      'month': month?.toIso8601String(),
    };
  }
}
