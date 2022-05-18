// ignore_for_file: file_names, must_be_immutable

import 'package:budget/src/models/userModel.dart';
import 'package:budget/src/modules/firebaseUserModule.dart';
import 'package:budget/src/modules/responseModel.dart';
import 'package:get/state_manager.dart';

class UserModule extends GetxController {
  final UserModel _userModel = UserModel();

  Rx<UserModel> currentUser = Rx(UserModel());
  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isSuperUser = false.obs;

  Future<UserModel> getUserById(String userId) async {
    final userMap = await _userModel.fetchOneById(userId);
    return UserModel.fromMap({'id': userMap.id, ...(userMap.data() ?? {})});
  }

  Future<void> setCurrentUser(String userId) async {
    currentUser.value = await getUserById(userId);
  }

  Future<ResponseModel> addUser(UserModel user) async {
    final _res = await FirebaseUser.createUser(
        user.email.toString(), user.password.toString());

    if (_res.status == ResponseType.success) {
      _userModel.saveOnlineWithId(_res.body.toString(), user.asMap());
      return ResponseModel(ResponseType.success, 'User Created');
    } else {
      return _res;
    }
  }
}
