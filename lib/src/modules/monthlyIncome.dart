import 'package:budget/src/models/monthlyIncome.dart';
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
  Stream<List<MonthlyIncomeModel>> fetchIncome() {
    return _monthlyIncomeModel.snapshotsOnline().map((snapshots) {
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
}
