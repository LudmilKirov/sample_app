import 'package:support_desk/data/services/users/model/user_model.dart';
import 'package:support_desk/data/services/users/user_service.dart';

abstract class UsersRepository {
  Future<List<User>> getUsers();
}

class UsersRepositoryImpl extends UsersRepository {
  final UsersService _service;

  UsersRepositoryImpl(this._service);

  @override
  Future<List<User>> getUsers() {
    return _service.getUsers();
  }

}
