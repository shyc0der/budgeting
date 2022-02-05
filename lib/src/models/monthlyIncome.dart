import 'package:budget/src/models/model.dart';

class MonthlyIncomeModel extends Model{
  
  MonthlyIncomeModel({this.id,this.salary,this.extraIncome,this.createdBy,DateTime? dateCreated})
  :super('monthlyIncome'){
    this.dateCreated =dateCreated ?? DateTime.now();
  }

  String? id;
  String? salary;
  String? extraIncome;
  String? createdBy;
  late DateTime dateCreated;

MonthlyIncomeModel.fromMap(Map map):super('monthlyIncome'){
  id=map['id'];
  salary=map['salary'];
  extraIncome=map['extraIncome'];
  createdBy=map['createdBy'];
  dateCreated=DateTime.tryParse(map['dateCreated'].toString()) ?? DateTime.now();
}
Map<String,dynamic>asMap(){
  return{
    'id': id,
    'salary': salary,
    'extraIncome': extraIncome,
    'createdBy': createdBy,
    'dateCreated': dateCreated.toIso8601String(),
  };
}

}