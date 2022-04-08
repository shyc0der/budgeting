import 'package:budget/src/models/model.dart';

class BudgetCategoryModel extends Model{
  BudgetCategoryModel({
    this.id,this.name,this.amountBudgeted,this.createdBy,DateTime? dateCreated
  }):super('budgetCategory'){
    this.dateCreated= dateCreated ?? DateTime.now();
  }
  String? id;
  String? name;
  String? amountBudgeted;
  late DateTime dateCreated ;
  String? createdBy;
  BudgetCategoryModel.fromMap(Map map):super('budgetCategory'){
    id=map['id'];
    name=map['name'];
    amountBudgeted=map['amountBudgeted'];
    createdBy=map['createdBy'];
    dateCreated=DateTime.tryParse(map['dateCreated'].toString()) ?? DateTime.now();
  }
  Map<String,dynamic> asMap(){
    return{
        'name': name,
        'amountBudgeted': amountBudgeted,
        'createdBy': createdBy,
        'dateCreated': dateCreated.toIso8601String(),
    };
  }
}