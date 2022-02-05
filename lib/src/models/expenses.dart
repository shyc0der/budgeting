import 'package:budget/src/models/model.dart';

class ExpenseModel extends Model{

  ExpenseModel ({this.budgetCategory,this.id,this.item,this.createdBy,DateTime? dateCreated,this.totalAmount}):super('expenses')
  {
    this.dateCreated=dateCreated ?? DateTime.now();
  }

String? id;
String? budgetCategory;
String? item;
String? totalAmount;
late DateTime dateCreated;
String? createdBy;

ExpenseModel.fromMap(Map map):super('expenses'){  
    id =map['id'];
    budgetCategory =map['budgetCategory'];
    item =map['item'];
    totalAmount =map['totalAmount'];
    dateCreated =DateTime.tryParse(map['dateCreated'].toString()) ?? DateTime.now();
    createdBy =map['createdBy'];  
}
Map<String,dynamic> asMap(){
  return{
    'id': id,
    'budgetCategory': budgetCategory,
    'item': item,
    'totalAmount': totalAmount,
    'dateCreated': dateCreated.toIso8601String(),
    'createdBy': createdBy,

  };
}

}