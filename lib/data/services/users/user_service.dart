import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:support_desk/data/services/users/model/user_model.dart';

abstract class UsersService {
  Future<List<User>> getUsers();
}

class UsersServiceImpl extends UsersService {

  @override
  Future<List<User>> getUsers() {
    return rootBundle //
        .loadString('assets/api.json')
        .then((json) => jsonDecode(json))
        .then((value) {
      return (value as List).map((i) => User.fromJson(i)).toList();
    });
  }
}
