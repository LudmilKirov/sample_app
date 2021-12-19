import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:support_desk/data/services/users/model/user_model.dart';

class UserDetailsController extends GetxController {
  late User user;
  late int index;
  final RxBool availability = false.obs;

  UserDetailsController();

  void init(User loadedUser) {
    user = loadedUser;
    availability.call(loadedUser.available);
  }

  void changeAvailability() {
    availability.toggle();
  }

  void onFinish() {
    //Create the new user with the new availability's value and pass it to the previous screen
    User newUser = user.copyWith(available: availability.value);
    user = newUser;
    Get.back(result: user);
  }
}
