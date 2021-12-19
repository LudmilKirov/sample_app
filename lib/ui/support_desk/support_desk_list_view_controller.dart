import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:support_desk/data/repositories/users/users_repository.dart';
import 'package:support_desk/data/services/users/model/user_model.dart';

class SupportDeskController extends GetxController {
  final UsersRepository usersRepository = Get.find();
  List<User> users = [];
  final RxList<User> usersForUi = <User>[].obs;
  final TextEditingController searchController = TextEditingController();

  final RxBool isLoading = RxBool(false);
  final RxBool isSearchTapped = RxBool(false);
  final Rxn<dynamic> error = Rxn<dynamic>();

  SupportDeskController();

  @override
  void onInit() {
    super.onInit();
    _getAccounts();
  }

  void search(String text) {
    usersForUi.clear();

    for (var user in users) {
      if (user.firstName.toLowerCase().contains(text.toLowerCase()) ||
          user.lastName.toLowerCase().contains(text.toLowerCase())) {
        usersForUi.add(user);
      }
    }

    usersForUi.call();
  }

  void updateUsers(User user) {
    usersForUi.clear();

    //Find the index of the user that was updated, remove it and add the new one at the same index
    int indexToManipulate = users.indexWhere((element) => element.phone == user.phone);
    users.removeAt(indexToManipulate);
    users.insert(indexToManipulate, user);

    for (var user in users) {
      usersForUi.add(user);
    }

    usersForUi.call();
  }

  void _getAccounts() {
    isLoading.call(true);
    usersRepository //
        .getUsers()
        .then(usersForUi)
        .catchError((dynamic error) => this.error.trigger(error))
        .whenComplete(() {
      for (var element in usersForUi) {
        users.add(element);
      }

      isLoading.call(false);
    });
  }
}
