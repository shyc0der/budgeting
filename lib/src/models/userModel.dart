// ignore_for_file: annotate_overrides, overridden_fields, file_names

import 'package:budget/src/models/model.dart';

class UserModel extends Model {
  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    DateTime? dateCreated,
  }) : super("users", "") {
    this.dateCreated = dateCreated ?? DateTime.now();
  }

  String? id;
  String? fullName;
  String? email;
  String? password;
  String? phoneNumber;
  late DateTime dateCreated;
  UserModel.fromMap(Map map) : super("users", "") {
    id = map['id'];
    fullName = map['fullName'];
    email = map['email'];
    phoneNumber = map['phoneNumber'];
    dateCreated = DateTime.tryParse(map['dateCreated'].toString()) ?? DateTime.now();
  }
  Map<String, dynamic> asMap() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'dateCreated': dateCreated.toIso8601String()
    };
  }
}
