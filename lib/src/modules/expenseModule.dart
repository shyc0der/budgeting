// ignore_for_file: file_names

import 'package:budget/src/models/expenses.dart';
import 'package:budget/src/models/userModel.dart';
import 'package:budget/src/modules/responseModel.dart';

class ExpenseModule {
  final ExpenseModel _expenseModel = ExpenseModel();

//add Expenses
  Future<ResponseModel> addExpenses(ExpenseModel expenseModel) async {
    await _expenseModel.saveOnline(expenseModel.asMap());
    return ResponseModel(ResponseType.success, 'Expense added Sucessfully');
  }

//update Expenses
  Future<ResponseModel> updateExpenses(
      String _id, Map<String, dynamic> expenseModel) async {
    await _expenseModel.updateOnline(_id, expenseModel);
    return ResponseModel(ResponseType.success, 'Updated Expense');
  }

//fetch Expenses
  Stream<List<ExpenseModel>> fetchExpenses(UserModel user) {
    return _expenseModel.snapshotsWhere('createdBy',isEqualTo: user.id).map((event) {
      return event.docs.map((e) {
        return ExpenseModel.fromMap({'id': e.id, ...e.data() as Map});
      }).toList();
    });
  }

//delete Expenses
  Future<ResponseModel> deleteExpenses(String _id) async {
    await _expenseModel.deleteOnline(_id);
    return ResponseModel(ResponseType.success, "Expense Deleted");
  }

  Future<ResponseModel> deleteExpenseExpenses(String _id, String id) async {    
     
     await _expenseModel.deleteCollection(_id, id);
         

    return ResponseModel(ResponseType.success, "Expense Deleted");
  }
}
