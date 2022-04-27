// ignore_for_file: file_names

import 'package:budget/src/models/budgetCategory.dart';
import 'package:budget/src/modules/responseModel.dart';

class BudgetCategoryModule{
  final BudgetCategoryModel _budgetCategoryModel=BudgetCategoryModel();
  //add Budget
  Future<ResponseModel> addBudget(BudgetCategoryModel budgetCategoryModel) async{
    await _budgetCategoryModel.saveOnline(budgetCategoryModel.asMap());
    return ResponseModel(ResponseType.success, "Budget Added");
  }
  //update Budget
  Future<ResponseModel> updateBudget(String _id,Map<String,dynamic> budgetModel) async{
    await _budgetCategoryModel.updateOnline(_id, budgetModel);
    return ResponseModel(ResponseType.success, "Budget Updated");
  }
  //fetch Budget
  Stream<List<BudgetCategoryModel>> fetchBudgets(){
    return _budgetCategoryModel.snapshotsOnline().map((event){
      return event.docs.map((e) {
        return BudgetCategoryModel.fromMap({'id':e.id,...e.data() as Map});
      }).toList();
    });
  }
//delete Budget
Future<ResponseModel> deleteBudget(String _id) async{
  await _budgetCategoryModel.deleteOnline(_id);
  return ResponseModel(ResponseType.success, "Budget Deleted");

}

 

}