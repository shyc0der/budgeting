// ignore_for_file: annotate_overrides, overridden_fields, file_names

import 'package:budget/src/models/model.dart';

class UserModel extends Model {
  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.userName,
    DateTime? dateCreated,
  }) : super("users", "") {
    this.dateCreated = dateCreated ?? DateTime.now();
  }

  String? id;
  String? fullName;
  String? userName;
  String? email;
  String? phoneNumber;
  late DateTime dateCreated;
  UserModel.fromMap(Map map) : super("users", "") {
    id = map['id'];
    fullName = map['fullName'];
    email = map['email'];
    phoneNumber = map['phoneNumber'];
    userName = map['userName'];
    dateCreated = DateTime.tryParse(map['dateCreated'].toString()) ?? DateTime.now();
  }
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userName': userName,
      'dateCreated': dateCreated.toIso8601String()
    };
  }
}
