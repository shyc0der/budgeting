import 'package:budget/src/models/model.dart';

class MonthlyIncomeModel extends Model {
  MonthlyIncomeModel(
      {this.id,
      this.salary,
      this.extraIncome,
      this.createdBy,
      DateTime? dateCreated,
      this.month})
      : super('monthlyIncome','extraIncome') {
    this.dateCreated = dateCreated ?? DateTime.now();
  }

  String? id;
  String? salary;
  List<Map<String, dynamic>>? extraIncome;
  String? createdBy;
  late DateTime dateCreated;
  DateTime? month;

  MonthlyIncomeModel.fromMap(Map map) : super('monthlyIncome','extraIncome') {
    id = map['id'];
    salary = map['salary'];
    extraIncome =
        List.from(map['extraIncome']).map((e) => Map<String,dynamic>.from(e)).toList();
    createdBy = map['createdBy'];
    month = DateTime.tryParse(map['month'].toString());
    dateCreated =
        DateTime.tryParse(map['dateCreated'].toString()) ?? DateTime.now();
  }
  Map<String, dynamic> asMap() {
    return {
      'salary': salary,
      'extraIncome': extraIncome,
      'createdBy': createdBy,
      'dateCreated': dateCreated.toIso8601String(),
      'month': month?.toIso8601String(),
    };
  }
}
