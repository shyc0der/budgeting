// ignore_for_file: file_names, must_be_immutable

import 'package:budget/src/models/userModel.dart';
import 'package:budget/src/modules/firebaseUserModule.dart';
import 'package:budget/src/modules/responseModel.dart';

class UserModule {
  final UserModel _userModel = UserModel();

  Future<ResponseModel> addUser(UserModel user) async {
    final _res = await FirebaseUser.createUser(
        user.email.toString(), user.password.toString());
    print(_res);
    print(_res.body.toString());
    if (_res.status == ResponseType.success) {
      print(_res.body.toString());
      _userModel.saveOnlineWithId(_res.body.toString(), user.asMap());
      return ResponseModel(ResponseType.success, 'User Created');
    } else {
      return _res;
    }
  }
}
