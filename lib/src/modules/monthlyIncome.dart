// ignore_for_file: file_names

import 'package:budget/src/models/monthlyIncome.dart';
import 'package:budget/src/models/userModel.dart';
import 'package:budget/src/modules/responseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyIncomeModule {
  final MonthlyIncomeModel _monthlyIncomeModel = MonthlyIncomeModel();

  //Add income
  Future<ResponseModel> addIncome(MonthlyIncomeModel monthlyIncomeModel) async {
    await _monthlyIncomeModel.saveOnline(monthlyIncomeModel.asMap());
    return ResponseModel(ResponseType.success, "income Created");
  }

  //fetch Income
  //Stram
  Stream<List<MonthlyIncomeModel>> fetchIncome(UserModel user) {
    return _monthlyIncomeModel
        .snapshotsWhere('createdBy', isEqualTo: user.id)
        .map((snapshots) {
      return snapshots.docs.map((doc) {
        return MonthlyIncomeModel.fromMap({'id': doc.id, ...doc.data() as Map});
      }).toList();
    });
  }

  //Future List
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchIncomeFuture() async {
    return (await _monthlyIncomeModel.fetchAll());
  }
  //update Income

  Future<ResponseModel> updateIncome(
      String _id, Map<String, dynamic> monthlyIncomeModel) async {
    await _monthlyIncomeModel.updateOnline(_id, monthlyIncomeModel);
    return ResponseModel(ResponseType.success, 'Income Updated');
  }

  Future<ResponseModel> deleteIncome(String? id) async {
    await _monthlyIncomeModel.deleteOnline(id!);
    return ResponseModel(ResponseType.success, 'Income Deleted');
  }

  Future<ResponseModel> deleteIncomeIncome(String? id, String _id) async {
    await _monthlyIncomeModel.deleteCollection(_id, _id);
    return ResponseModel(ResponseType.success, 'Income Deleted');
  }
}
